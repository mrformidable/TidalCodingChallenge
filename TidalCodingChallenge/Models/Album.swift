//
//  Album.swift
//  TidalCodingChallenge
//
//  Created by Michael Aidoo on 2022-03-12.
//

import Foundation

public struct Album: Codable, Equatable {
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
    releaseDate = try container.decode(String.self, forKey: .releaseDate).toAlbumReleaseDate()
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id, forKey: .id)
    try container.encode(title, forKey: .title)
    try container.encode(imageURL?.absoluteString, forKey: .imageURL)
    try container.encode(thumbnailURL?.absoluteString, forKey: .thumbnailURL)
    try container.encode(usesExplicitLyrics, forKey: .usesExplicitLyrics)
    try container.encode(releaseDate.toAlbumReleaseDate(), forKey: .releaseDate)
  }
  
  public static func ==(lhs: Album, rhs: Album) -> Bool {
    return lhs.id == rhs.id
  }
}
