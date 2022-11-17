//
//  Launch.swift
//  TheSpaceDevs2.0
//
//  Created by anastasiia.gachkovskaia on 16/11/2022.
//

import Foundation

struct Launch: Equatable {
    let name: String
    let url: String
    
    static let initial = Launch(name: "", url: "")
}

extension Launch {
    static var fake = Launch(name: "Long March 6A | Unknown Payload", url: "")
}
