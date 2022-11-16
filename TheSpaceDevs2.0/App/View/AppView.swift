//
//  AppView.swift
//  TheSpaceDevs2.0
//
//  Created by anastasiia.gachkovskaia on 15/11/2022.
//

import ComposableArchitecture
import SwiftUI

struct LanchesInternalState {
    var filterQuery: String

    init() {
        self.filterQuery = ""
    }

    init(state: OverviewFeature.State) {
        self.filterQuery = state.filterQuery
    }
}

struct AppView: View {
      // MARK: - Properties
    
    let store: Store<AppFeature.State, AppFeature.Action>
    let overview: Overview
    
    var body: some View {
        WithViewStore(store) { viewStore in
            NavigationView {
                HStack {
                    overview
                }
            }
        }
    }
    
    public init(store: StoreOf<AppFeature>) {
        self.store = store
        overview = Overview(
            store: store.scope(
                state: \.overviewState.view,
                action: { local -> AppFeature.Action in
                    AppFeature.Action.overview(
                        OverviewFeature.Action.view(local)
                    )
                }
            )
        )
    }
}

// MARK: - PreviewProvider

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(
            store:
                Store(
                    initialState: AppFeature.State(
                        launches: [
                            Launch(name: "Long March 6A | Unknown Payload"),
                            Launch(name: "Long March 6A | Unknown Payload"),
                            Launch(name: "Long March 6A | Unknown Payload"),
                            Launch(name: "Long March 6A | Unknown Payload")
                        ]
                    ),
                    reducer: EmptyReducer()
                )
        )
    }
}
