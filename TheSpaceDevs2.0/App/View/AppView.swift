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
    let overview: OverviewView
    
    var body: some View {
        WithViewStore(store) { viewStore in
            NavigationView {
                HStack {
                    overview
                    // TODO: redo on navigation stack
                    NavigationLink(
                        destination: detailsView,
                        isActive: viewStore.binding(
                            get: { $0.detailsState != nil },
                            send: .dissappear
                        ),
                        label: EmptyView.init
                    )
                }
            }
        }
    }
    
    var detailsView: some View {
        IfLetStore(
            store.scope(
                state: \.detailsState?.view,
                action: { local -> AppFeature.Action in
                    AppFeature.Action.details(DetailsFeature.Action.view(local))
                }
            ),
            then: DetailsView.init(store:)
        )
    }
    
    public init(store: StoreOf<AppFeature>) {
        self.store = store
        overview = OverviewView(
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

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(
            store:
                Store(
                    initialState: AppFeature.State(
                        launches: [.fake, .fake, .fake]
                    ),
                    reducer: EmptyReducer()
                )
        )
    }
}
#endif

