//
//  SearchedTrackResult.swift
//  TidalCodingChallenge
//
//  Created by Michael Aidoo on 2022-03-12.
//

import Foundation

struct SearchedTrackResult: Codable, Equatable {
  enum CodingKeys: String, CodingKey {
    case tracks = "data"
    case total
  }
  
  let tracks: [Track]
  let total: Int
  
  static func ==(lhs: SearchedTrackResult, rhs: SearchedTrackResult) -> Bool {
    return lhs.tracks == rhs.tracks && lhs.total == rhs.total
  }
}
