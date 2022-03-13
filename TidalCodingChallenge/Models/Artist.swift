//
//  Artist.swift
//  TidalCodingChallenge
//
//  Created by Michael Aidoo on 2022-03-12.
//

import Foundation

public struct Artist: Codable, Equatable {
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case imageURL = "picture_big"
    case thumbnailURL = "picture_small"
  }
  
  public let id: Int
  public let name: String
  public let imageURL: URL?
  public let thumbnailURL: URL?
  
  public init(id: Int, name: String, imageURL: URL?, thumbnailURL: URL?) {
    self.id = id
    self.name = name
    self.imageURL = imageURL
    self.thumbnailURL = thumbnailURL
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decode(Int.self, forKey: .id)
    name = try container.decode(String.self, forKey: .name)
    imageURL = try container.decode(String.self, forKey: .imageURL).toURL()
    thumbnailURL = try container.decode(String.self, forKey: .thumbnailURL).toURL()
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id, forKey: .id)
    try container.encode(name, forKey: .name)
    try container.encode(imageURL?.absoluteString, forKey: .imageURL)
    try container.encode(thumbnailURL?.absoluteString, forKey: .thumbnailURL)
  }
  
  public static func ==(lhs: Artist, rhs: Artist) -> Bool {
    return lhs.id == rhs.id
  }
}

extension Artist {
  static var mock: Artist {
    Artist(id: 146791, name: "Drake", imageURL: MockImageURLs.artist, thumbnailURL: MockImageURLs.artist)
  }
}

