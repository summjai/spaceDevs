//
//  AppFeature.swift
//  TheSpaceDevs2.0
//
//  Created by anastasiia.gachkovskaia on 16/11/2022.
//

import ComposableArchitecture
import SwiftUI
import Foundation

struct AppFeature: ReducerProtocol {
    struct State: Equatable {
        public static let initial = State(launches: [], detailsState: nil)
        
        var launches: [Launch]
        var overviewInternal = OverviewInternalState()
        var detailsState: DetailsFeature.State?

        var overviewState: OverviewFeature.State {
            get {
                OverviewFeature.State(internalState: overviewInternal, launches: launches)
            }
            set {
                overviewInternal = .init(state: newValue)
                launches = newValue.launches
            }
        }
    }
    
    enum Action: Equatable {
        case overview(OverviewFeature.Action)
        case details(DetailsFeature.Action)
        case dissappear
    }
    
    public var body: some ReducerProtocol<State, Action> {
        Scope(state: \.overviewState, action: /Action.overview) {
          OverviewFeature()
        }
        .ifLet(\.detailsState, action: /Action.details) {
            DetailsFeature()
        }
        Reduce { state, action in
            switch action {
            case .dissappear:
                state.detailsState = nil
                return .none
            case .overview(.launchWasSelected):
                state.detailsState = DetailsFeature.State.initial
                return .none
            case .overview, .details:
                return .none
            }
        }
    }
}

extension OverviewFeature.State {
    init(
        internalState: OverviewInternalState,
        launches: [Launch]
    ) {
        self.init(
            filterQuery: internalState.filterQuery,
            launches: launches
        )
    }
}
