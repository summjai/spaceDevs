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
        public static let initial = State(launches: [])
        
        var launches: [Launch]
        var overviewInternal = OverviewInternalState()

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
    }
    
    public var body: some ReducerProtocol<State, Action> {
        Scope(state: \.overviewState, action: /Action.overview) {
          OverviewFeature()
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
