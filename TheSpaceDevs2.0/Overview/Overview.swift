//
//  Overview.swift
//  TheSpaceDevs2.0
//
//  Created by anastasiia.gachkovskaia on 15/11/2022.
//

import ComposableArchitecture
import SwiftUI

struct Overview: View {
    // MARK: - Types
    
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

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            // MARK: - Loaded
            Overview(
                store: Store(
                    initialState: Overview.ViewState(
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
            
            // MARK: - Loading
            Overview(
                store: Store(
                    initialState: Overview.ViewState(
                        filterText: "",
                        loadingState: .loading
                    ),
                    reducer: EmptyReducer()
                )
            )
        }
    }
}
