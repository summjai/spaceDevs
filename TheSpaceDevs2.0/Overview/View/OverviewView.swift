//
//  OverviewView.swift
//  TheSpaceDevs2.0
//
//  Created by anastasiia.gachkovskaia on 15/11/2022.
//

import ComposableArchitecture
import SwiftUI
import Foundation

struct OverviewView: View {
    // MARK: - Store
    
    struct ViewState: Equatable {
        let filterText: String
        let loadingState: LoadingState
        
        enum LoadingState: Equatable {
            case loaded(launches: [String])
            case loading
            
            var launches: [String] {
                guard case .loaded(let launches) = self else { return [] }
                return launches
            }
            var isLoading: Bool { self == .loading }
        }
        
        static func convert(from state: OverviewFeature.State) -> Self {
            .init(
                filterText: state.filterQuery,
                loadingState: loadingState(from: state)
            )
        }
        
        private static func loadingState(
            from state: OverviewFeature.State
        ) -> LoadingState {
            if state.launches.isEmpty { return .loading }
            
            var launches = state.launches.map(\.name)
            if !state.filterQuery.isEmpty {
                launches = launches.filter {
                    $0.lowercased().contains(state.filterQuery.lowercased())
                }
            }
            
            return .loaded(launches: launches)
        }
    }
    
    enum ViewAction: Equatable {
        case cellWasSelected(launch: String)
        case onAppear
        case filterTextChanged(String)
    }
    
    // MARK: - Properties
    
    var store: Store<ViewState, ViewAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                if viewStore.loadingState.isLoading {
                    ProgressView()
                } else {
                    searchBar(for: viewStore)
                    launchesList(for: viewStore)
                }
            }
            .navigationBarTitle("Launches")
            .padding()
            
            .onAppear { viewStore.send(.onAppear) }
        }
    }
    
    // MARK: - ViewBuilder
    
    @ViewBuilder
    private func searchBar(
        for viewStore: ViewStore<ViewState, ViewAction>
    ) -> some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField(
                "Search",
                text: viewStore.binding(
                    get: \.filterText,
                    send: ViewAction.filterTextChanged
                )
            )
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .autocapitalization(.none)
            .disableAutocorrection(true)
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func launchesList(
        for viewStore: ViewStore<ViewState, ViewAction>
    ) -> some View {
        ScrollView {
            ForEach(viewStore.loadingState.launches, id: \.self) { launch in
                VStack {
                    // TODO: check
                    Button(action: { viewStore.send(.cellWasSelected(launch: launch)) } ) {
                        HStack {
                            Text(launch)
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                    }
                    Divider()
                }
                .foregroundColor(.primary)
            }
            .padding()
        }
    }
}

// MARK: - PreviewProvider

#if DEBUG
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            // MARK: - Loaded
            OverviewView(
                store: Store(
                    initialState: OverviewView.ViewState(
                        filterText: "",
                        loadingState: .loaded(
                            launches: [
                                "Long March 6A | Unknown Payload",
                                "Long March 6A | Unknown Payload",
                                "Long March 6A | Unknown Payload"
                            ]
                        )
                    ),
                    reducer: EmptyReducer()
                )
            )
        }
        
        // MARK: - Loading
        NavigationView {
            OverviewView(
                store: Store(
                    initialState: OverviewView.ViewState(
                        filterText: "",
                        loadingState: .loading
                    ),
                    reducer: EmptyReducer()
                )
            )
        }
    }
}
#endif
