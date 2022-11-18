//
//  TheSpaceDevs2_0App.swift
//  TheSpaceDevs2.0
//
//  Created by anastasiia.gachkovskaia on 15/11/2022.
//

import ComposableArchitecture
import SwiftUI

@main
struct TheSpaceDevs2_0App: App {
    var body: some Scene {
        WindowGroup {
            AppView(
                store:
                    Store(
                        initialState: AppFeature.State(launches: []),
                        reducer: AppFeature()
                    )
            )
        }
    }
}

