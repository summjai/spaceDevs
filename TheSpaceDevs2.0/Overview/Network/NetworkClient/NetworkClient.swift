//
//  NetworkClient.swift
//  TheSpaceDevs2.0
//
//  Created by anastasiia.gachkovskaia on 17/11/2022.
//

import Combine
import Foundation

struct NetworkClient {
    var perform: (URL) -> AnyPublisher<Data, Error>
}

extension NetworkClient {
    static let live = NetworkClient { url in
        URLSession
            .shared
            .dataTaskPublisher(for: url)
            .catch({ error in
                AnyPublisher(error: error)
            })
            .map(\.data)
            .eraseToAnyPublisher()
    }
}
