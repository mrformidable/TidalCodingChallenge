//
//  SearchedAlbumResult.swift
//  TidalCodingChallenge
//
//  Created by Michael Aidoo on 2022-03-12.
//

import Foundation

struct SearchedAlbumResult: Codable, Equatable {
  enum CodingKeys: String, CodingKey {
    case albums = "data"
    case total
  }
  
  let albums: [Album]
  let total: Int
  
  static func ==(lhs: SearchedAlbumResult, rhs: SearchedAlbumResult) -> Bool {
    return lhs.albums == rhs.albums && lhs.total == rhs.total
  }
}
