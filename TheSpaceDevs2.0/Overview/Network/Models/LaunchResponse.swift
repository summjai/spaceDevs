//
//  LaunchResponse.swift
//  TheSpaceDevs2.0
//
//  Created by anastasiia.gachkovskaia on 17/11/2022.
//

import Foundation

struct LaunchesResponse: Decodable {
    let results: [LaunchResults]

    struct LaunchResults: Decodable {
        let name: String
        let url: String
    }
}

