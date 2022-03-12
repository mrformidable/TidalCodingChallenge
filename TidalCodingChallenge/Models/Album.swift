//
//  Album.swift
//  TidalCodingChallenge
//
//  Created by Michael Aidoo on 2022-03-12.
//

import Foundation

public struct Album: Decodable, Equatable {
  enum CodingKeys: String, CodingKey {
    case id
    case title
    case imageURL = "cover_big"
    case thumbnailURL = "cover_small"
    case usesExplicitLyrics = "explicit_lyrics"
    case releaseDate = "release_date"
  }
  
  public let id: Int
  public let title: String
  public let imageURL: URL?
  public let thumbnailURL: URL?
  public let usesExplicitLyrics: Bool
  public let releaseDate: Date
  
  public init(id: Int, title: String, imageURL: URL?, thumbnailURL: URL?, usesExplicitLyrics: Bool, releaseDate: Date) {
    self.id = id
    self.title = title
    self.imageURL = imageURL
    self.thumbnailURL = thumbnailURL
    self.usesExplicitLyrics = usesExplicitLyrics
    self.releaseDate = releaseDate
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decode(Int.self, forKey: .id)
    title = try container.decode(String.self, forKey: .title)
    imageURL = try container.decode(String.self, forKey: .imageURL).toURL()
    thumbnailURL = try container.decode(String.self, forKey: .thumbnailURL).toURL()
    usesExplicitLyrics = try container.decode(Bool.self, forKey: .usesExplicitLyrics)
    releaseDate = try container.decode(String.self, forKey: .releaseDate).toReleaseDate()
  }
  
  public static func ==(lhs: Album, rhs: Album) -> Bool {
    return lhs.id == rhs.id
  }
}
