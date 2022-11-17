//
//  OverviewInternalState.swift
//  TheSpaceDevs2.0
//
//  Created by anastasiia.gachkovskaia on 16/11/2022.
//

import Foundation

struct OverviewInternalState: Equatable {
    var filterQuery: String

    init() {
        self.filterQuery = ""
    }

    init(state: OverviewFeature.State) {
        self.filterQuery = state.filterQuery
    }
}
