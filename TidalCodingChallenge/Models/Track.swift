//
//  Track.swift
//  TidalCodingChallenge
//
//  Created by Michael Aidoo on 2022-03-12.
//

import Foundation

public struct Track: Codable, Equatable {
  enum CodingKeys: String, CodingKey {
    case id
    case title
    case duration
    case position = "track_position"
    case usesExplicitLyrics = "explicit_lyrics"
  }
  
  public let id: Int
  public let title: String
  public let duration: Int
  public let position: Int
  public let usesExplicitLyrics: Bool
  
  public init(id: Int, title: String, duration: Int, position: Int, usesExplicitLyrics: Bool) {
    self.id = id
    self.title = title
    self.duration = duration
    self.position = position
    self.usesExplicitLyrics = usesExplicitLyrics
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decode(Int.self, forKey: .id)
    title = try container.decode(String.self, forKey: .title)
    duration = try container.decode(Int.self, forKey: .duration)
    position = try container.decode(Int.self, forKey: .position)
    usesExplicitLyrics = try container.decode(Bool.self, forKey: .usesExplicitLyrics)
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id, forKey: .id)
    try container.encode(title, forKey: .title)
    try container.encode(duration, forKey: .duration)
    try container.encode(position, forKey: .position)
    try container.encode(usesExplicitLyrics, forKey: .usesExplicitLyrics)
  }
  
  public static func ==(lhs: Track, rhs: Track) -> Bool {
    return lhs.id == rhs.id
  }
}

extension Track {
  static var mock: Track {
    Track(id: 21312, title: "Album", duration: 300, position: 1, usesExplicitLyrics: true)
  }
}
