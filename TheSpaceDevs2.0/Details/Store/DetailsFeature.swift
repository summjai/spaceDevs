//
//  DetailsFeature.swift
//  TheSpaceDevs2.0
//
//  Created by anastasiia.gachkovskaia on 16/11/2022.
//

import ComposableArchitecture
import Foundation

struct DetailsFeature: ReducerProtocol {
    // MARK: - Reducer
    
    struct State: Equatable {
        var launch: Launch
        var details: Details
        
        static let initial = State(launch: .initial, details: .initial)
        
        var view: DetailsView.ViewState {
            DetailsView.ViewState.convert(from: self)
        }
    }
    
    enum Action: Equatable {
        case detailsLoaded(details: Details?)
        case loadDetails
        
        static func view(_ localAction: DetailsView.ViewAction) -> Self {
            switch localAction {
            case .onAppear:
                return .loadDetails
            }
        }
    }
    
    public func reduce(into state: inout State, action: Action) -> Effect<Action, Never> {
        switch action {
        case .detailsLoaded(details: let details):
            guard let details else { return .none }
            state.details.description = details.description
            return .none
        case .loadDetails:
            return EffectPublisher(value: Action.detailsLoaded(details: nil))
        }
    }
}
