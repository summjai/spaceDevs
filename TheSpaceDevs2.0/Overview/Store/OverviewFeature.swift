//
//  OverviewFeature.swift
//  TheSpaceDevs2.0
//
//  Created by anastasiia.gachkovskaia on 15/11/2022.
//

import ComposableArchitecture
import Foundation

struct OverviewFeature: ReducerProtocol {
    struct State {
        var filterQuery: String
        var launches: [Launch]
    }
    
    enum Action {
        case missionWasSelected(name: String)
        case missionsLoaded([Launch])
        case filterQueryChanged(String)
        case loadMissions
    }
    
    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .missionWasSelected(name: let name):
                return .none
            case .missionsLoaded(_):
                return .none
            case .filterQueryChanged(_):
                return .none
            case .loadMissions:
                return .none
            }
        }
    }
}
