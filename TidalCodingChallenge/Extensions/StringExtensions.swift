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
  
  func toAlbumReleaseDate() -> Date {
    let formatter = DateFormatter()
    formatter.dateFormat = "YYYY-MM-dd"
    return formatter.date(from: self) ?? Date()
  }
}
