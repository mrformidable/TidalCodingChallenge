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
    case next
  }
  
  let artists: [Artist]
  let total: Int
  let next: String
  
  init(artists: [Artist], total: Int, next: String) {
    self.artists = artists
    self.total = total
    self.next = next
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    artists = try container.decode([Artist].self, forKey: .artists)
    total = try container.decode(Int.self, forKey: .total)
    next = try container.decodeIfPresent(String.self, forKey: .next) ?? ""
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(artists, forKey: .artists)
    try container.encode(total, forKey: .total)
    try container.encode(next, forKey: .next)
  }
  
  static func ==(lhs: SearchedArtistResult, rhs: SearchedArtistResult) -> Bool {
    return lhs.artists == rhs.artists &&
    lhs.total == rhs.total &&
    lhs.next == rhs.next
  }
}
