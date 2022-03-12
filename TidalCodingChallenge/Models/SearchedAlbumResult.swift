//
//  SearchedAlbumResult.swift
//  TidalCodingChallenge
//
//  Created by Michael Aidoo on 2022-03-12.
//

import Foundation

struct SearchedAlbumResult: Decodable {
  enum CodingKeys: String, CodingKey {
    case albums = "data"
    case total
    case next
  }
  
  let albums: [Album]
  let total: Int
  let next: String
}
