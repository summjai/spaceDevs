//
//  DetailsView.swift
//  TheSpaceDevs2.0
//
//  Created by anastasiia.gachkovskaia on 16/11/2022.
//

import Foundation
import ComposableArchitecture
import SwiftUI

struct DetailsView: View {
    
    struct ViewState: Equatable {
        let title: String
        let loadingState: LoadingState
        
        enum LoadingState: Equatable {
            case loaded(details: Details)
            case loading
            
            var details: Details {
                guard case .loaded(let details) = self else { return .initial }
                return details
            }
            var isLoading: Bool { self == .loading }
        }
        
        static func convert(from state: DetailsFeature.State) -> Self {
            .init(title: state.launch.name, loadingState: loadingState(from: state))
        }
        
        private static func loadingState(from state: DetailsFeature.State) -> LoadingState {
            // TODO: Make details optional
            return .loaded(details: state.details)
        }
    }
    
    enum ViewAction {
        case onAppear
    }
    
    // MARK: - Properties
    
    var store: Store<ViewState, ViewAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        launchImage(for: viewStore)
                    }
                    VStack {
                        launchName(for: viewStore)
                        Spacer().frame(height: 8.0)
                        launchCaption(for: viewStore)
                        Spacer().frame(height: 24.0)
                        VStack {
                            timer(for: viewStore)
                            launchDate(for: viewStore)
                        }
                    }
                    Spacer()
                }
                .padding(.top)
                HStack {
                    Spacer().frame(width: 4.0)
                    Image("location")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(20.0)
                    Spacer().frame(width: 4.0)
                }
                Spacer()
            }
            .background(Color.black.opacity(0.86))
        }
    }
    
    // MARK: - Private properties
    
    @ViewBuilder
    func launchImage(
        for viewStore: ViewStore<ViewState, ViewAction>
    ) -> some View {
        Image("test")
            .resizable()
            .scaledToFill()
            .frame(
                width: 200.0,
                height: 400.0
            )
            .clipped()
            .cornerRadius(20.0)
            .padding(.leading)
    }
        
    @ViewBuilder
    private func launchName(
        for viewStore: ViewStore<ViewState, ViewAction>
    ) ->  some View {
        Text(viewStore.title)
            .foregroundColor(.white)
            .font(.title3)
            .underline()
            .bold()
    }
    
    @ViewBuilder
    func launchCaption(
        for viewStore: ViewStore<ViewState, ViewAction>
    ) -> some View {
        Text(viewStore.loadingState.details.description)
            .foregroundColor(.white)
            .font(.caption2)
    }
    
    @ViewBuilder
    func timer(
        for viewStore: ViewStore<ViewState, ViewAction>
    ) -> some View {
        Text("T+ 23 : 24 : 00")
            .padding()
            .background(.blue)
            .clipShape(Capsule())
    }
    
    @ViewBuilder
    func launchDate(
        for viewStore: ViewStore<ViewState, ViewAction>
    ) -> some View {
        Text("12/11/2022, 00:00:00")
            .foregroundColor(.white)
            .font(.caption2)
    }
}

// MARK: - PreviewProvider

struct DetailsView_Preview: PreviewProvider {
    static var previews: some View {
        DetailsView(
            store: Store(
                initialState: DetailsView.ViewState.fake,
                reducer: EmptyReducer()
            )
        )
    }
}
