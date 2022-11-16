//
//  OverviewFeature.swift
//  TheSpaceDevs2.0
//
//  Created by anastasiia.gachkovskaia on 15/11/2022.
//

import ComposableArchitecture
import Foundation

struct OverviewFeature: ReducerProtocol {
    // MARK: - Store
    struct State: Equatable {
        var filterQuery: String
        var launches: [Launch]
        
        var view: OverviewView.ViewState {
            OverviewView.ViewState.convert(from: self)
        }
    }
    
    enum Action: Equatable {
        case launchWasSelected(name: String) // TODO: by id?
        case launchesLoaded([Launch])
        case filterQueryChanged(String)
        case loadLaunches
        
        static func view(_ localAction: OverviewView.ViewAction) -> Self {
            switch localAction {
            case .cellWasSelected(let breed):
                return .launchWasSelected(name: breed)
            case .onAppear:
                return .loadLaunches
            case .filterTextChanged(let newValue):
                return .filterQueryChanged(newValue)
            }
        }
    }
    
    // MARK: - Response
    struct LaunchesResponse: Decodable {
        let results: [LaunchResults]
    
        struct LaunchResults: Decodable {
            let name: String
            let url: String
        }
    }
    
    // MARK: - Properties
    
    public func reduce(into state: inout State, action: Action) -> Effect<Action, Never> {
        switch action {
        case .launchWasSelected:
            return .none
        case .launchesLoaded(let launches):
            state.launches = launches
            return .none
        case .filterQueryChanged(_):
            return .none
        case .loadLaunches:
            return URLSession.shared
                .dataTaskPublisher(for: URL(string: "https://ll.thespacedevs.com/2.0.0/launch/upcoming/?limit=10&offset=10")!)
                .map(\.data)
                .decode(type: LaunchesResponse.self, decoder: JSONDecoder())
                .map { response in
                    response
                        .results
                        .map { launch in
                            Launch(
                                name: launch.name,
                                url: launch.url
                            )
                        }
                }
                .replaceError(with: [])
                .receive(on: DispatchQueue.main)
                .eraseToEffect()
                .map(OverviewFeature.Action.launchesLoaded)
        }
    }
}
