//
//  LaunchesService.swift
//  TheSpaceDevs2.0
//
//  Created by anastasiia.gachkovskaia on 17/11/2022.
//

import ComposableArchitecture
import Combine
import Foundation

enum LaunchesService {
    static func fetchLaunches(
        fetch: @escaping (URL) -> AnyPublisher<Data, Error>
    ) -> () -> Effect<[Launch], Never> {
        {
            fetch(URL(string: "https://ll.thespacedevs.com/2.0.0/launch/upcoming/?limit=10&offset=10")!)
                .decode(type: LaunchesResponse.self, decoder: JSONDecoder())
                .map { response in
                    response
                        .results
                        .map { launch in
                            Launch(
                                name: launch.name,
                                url: launch.url
                            )
                        }
                }
                .replaceError(with: [])
                .receive(on: DispatchQueue.main)
                .eraseToEffect()
        }
    }
}

// MARK: - Live

extension LaunchesService {
    static let live: () -> Effect<[Launch], Never> = LaunchesService.fetchLaunches(fetch: NetworkClient.live.perform)
}

