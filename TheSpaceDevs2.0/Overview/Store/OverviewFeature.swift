//
//  OverviewFeature.swift
//  TheSpaceDevs2.0
//
//  Created by anastasiia.gachkovskaia on 15/11/2022.
//

import ComposableArchitecture
import Foundation

struct OverviewFeature: ReducerProtocol {
    // MARK: - Reducer
    struct State: Equatable {
        var filterQuery: String
        var launches: [Launch]
        
        var view: OverviewView.ViewState {
            OverviewView.ViewState.convert(from: self)
        }
    }
    
    enum Action: Equatable {
        case launchWasSelected(name: String) // TODO: delete name
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
            return LaunchesService.live().map(OverviewFeature.Action.launchesLoaded)
        }
    }
}
