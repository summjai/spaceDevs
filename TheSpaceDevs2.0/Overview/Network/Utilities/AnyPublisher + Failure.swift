//
//  AnyPublisher + Failure.swift
//  TheSpaceDevs2.0
//
//  Created by anastasiia.gachkovskaia on 17/11/2022.
//

import Combine
import Foundation

extension AnyPublisher {
  init(error: Failure) {
    self = Fail(error: error)
      .eraseToAnyPublisher()
  }
}

