//
//  StringExtensions.swift
//  TidalCodingChallenge
//
//  Created by Michael Aidoo on 2022-03-12.
//

import Foundation

extension String {
  func toURL() -> URL? {
    URL(string: self)
  }
  
  func toReleaseDate() -> Date {
    return DateFormatter().date(from: self) ?? Date()
  }
}
