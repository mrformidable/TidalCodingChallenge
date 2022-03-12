//
//  SearchedTrackResult.swift
//  TidalCodingChallenge
//
//  Created by Michael Aidoo on 2022-03-12.
//

import Foundation

struct SearchedTrackResult: Decodable {
  enum CodingKeys: String, CodingKey {
    case tracks = "data"
    case total
  }
  
  let tracks: [Track]
  let total: Int
}
