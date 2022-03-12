//
//  SearchCacheService.swift
//  TidalCodingChallenge
//
//  Created by Michael Aidoo on 2022-03-12.
//

import Foundation

protocol SearchCacheStore {
  func cacheAlbums(_ albums: [Album], key: String)
  func cacheTracks(_ tracks: [Track], key: String)
  func getAlbums(using id: String) -> [Album]
  func getTracks(using id: String) -> [Track]
}

final class SearchCacheService: SearchCacheStore {
  
  static let shared = SearchCacheService()
  
  private let albumsCache: NSCache<NSString, CacheableWrapper<[Album]>>
  private let tracksCache: NSCache<NSString, CacheableWrapper<[Track]>>
  
  private init(
    albumsCache: NSCache<NSString, CacheableWrapper<[Album]>> = NSCache<NSString, CacheableWrapper<[Album]>>(),
    tracksCache: NSCache<NSString, CacheableWrapper<[Track]>> = NSCache<NSString, CacheableWrapper<[Track]>>()
  ) {
    self.albumsCache = albumsCache
    self.tracksCache = tracksCache
  }
  
  func cacheAlbums(_ albums: [Album], key: String) {
    albumsCache.setObject(CacheableWrapper(albums), forKey: key as NSString)
  }
  
  func cacheTracks(_ tracks: [Track], key: String) {
    tracksCache.setObject(CacheableWrapper(tracks), forKey: key as NSString)
  }
  
  func getAlbums(using key: String) -> [Album] {
    guard let albums = self.albumsCache.object(forKey: key as NSString)?.value else {
      return []
    }
    return albums
  }
  
  func getTracks(using key: String) -> [Track] {
    guard let tracks = self.tracksCache.object(forKey: key as NSString)?.value else {
      return []
    }
    return tracks
  }
  
}
