//
//  DetailsView.ViewState + Fake.swift
//  TheSpaceDevs2.0
//
//  Created by anastasiia.gachkovskaia on 16/11/2022.
//

import Foundation

extension DetailsView.ViewState {
    static var fake = DetailsView.ViewState(
        title: "China Aerospace Science and Technology Corporation",
        loadingState: .loaded(details: Details(description: ""))
    )
}
