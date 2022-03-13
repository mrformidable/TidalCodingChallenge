//
//  DateExtensions.swift
//  TidalCodingChallenge
//
//  Created by Michael Aidoo on 2022-03-12.
//

import Foundation

extension Date {
  func toAlbumReleaseDate() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "YYYY-MM-dd"
    return formatter.string(from: self)
  }
  
  func getAlbumReleaseYear() -> String {
    let year = Calendar.current.dateComponents([.year], from: self).year ?? 2022
    return String(year)
  }
}
