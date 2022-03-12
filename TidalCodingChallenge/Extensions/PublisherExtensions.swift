//
//  PublisherExtensions.swift
//  TidalCodingChallenge
//
//  Created by Michael Aidoo on 2022-03-12.
//

import Foundation
import Combine

extension Publisher {
  func asyncMap<T>(
    _ transform: @escaping (Output) async -> T
  ) -> Publishers.FlatMap<Future<T, Never>, Self> {
    flatMap { value in
      Future { promise in
        Task {
          let output = await transform(value)
          promise(.success(output))
        }
      }
    }
  }
}
