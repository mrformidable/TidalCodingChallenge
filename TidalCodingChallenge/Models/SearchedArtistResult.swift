//
//  SearchedArtistResult.swift
//  TidalCodingChallenge
//
//  Created by Michael Aidoo on 2022-03-12.
//

import Foundation

struct SearchedArtistResult: Decodable {
  enum CodingKeys: String, CodingKey {
    case artists = "data"
    case total
    case next
  }
  
  let artists: [Artist]
  let total: Int
  let next: String
}
