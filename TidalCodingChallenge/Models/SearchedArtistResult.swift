//
//  SearchedArtistResult.swift
//  TidalCodingChallenge
//
//  Created by Michael Aidoo on 2022-03-12.
//

import Foundation

struct SearchedArtistResult: Codable, Equatable {
  enum CodingKeys: String, CodingKey {
    case artists = "data"
    case total
  }
  
  let artists: [Artist]
  let total: Int
  
  init(artists: [Artist], total: Int, next: String) {
    self.artists = artists
    self.total = total
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    artists = try container.decode([Artist].self, forKey: .artists)
    total = try container.decode(Int.self, forKey: .total)
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(artists, forKey: .artists)
    try container.encode(total, forKey: .total)
  }
  
  static func ==(lhs: SearchedArtistResult, rhs: SearchedArtistResult) -> Bool {
    return lhs.artists == rhs.artists && lhs.total == rhs.total
  }
}
