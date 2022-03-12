//
//  SearchCloudService.swift
//  TidalCodingChallenge
//
//  Created by Michael Aidoo on 2022-03-12.
//

import Foundation

protocol SearchCloudStore {
  func getAlbums(using artistId: String) async throws -> Result<SearchedAlbumResult, Error>
  func getTracks(using albumId: String) async throws -> Result<SearchedTrackResult, Error>
  func searchArtist(matching query: String) async throws -> Result<SearchedArtistResult, Error>
}

final class SearchCloudService: SearchCloudStore {
  
  private let session: URLSessionProtocol
  
  init(session: URLSessionProtocol = URLSession.shared) {
    self.session = session
  }
  
  func searchArtist(matching query: String) async throws -> Result<SearchedArtistResult, Error> {
    let adapter = NetworkAPIAdapter.artistSearch(query)
    
    guard let request = adapter.request else {
      throw NetworkError.invalidRequest
    }
    
    let decodedArtistResult: Result<SearchedArtistResult, Error> = try await decodeNetworkData(with: request)
    return decodedArtistResult
  }
  
  func getAlbums(using artistId: String) async throws -> Result<SearchedAlbumResult, Error> {
    let adapter = NetworkAPIAdapter.albums(artistId)
    
    guard let request = adapter.request else {
      throw NetworkError.invalidRequest
    }
    
    let decodedAlbumResult: Result<SearchedAlbumResult, Error> = try await decodeNetworkData(with: request)
    return decodedAlbumResult
  }
  
  func getTracks(using albumId: String) async throws -> Result<SearchedTrackResult, Error> {
    let adapter = NetworkAPIAdapter.tracks(albumId)
    
    guard let request = adapter.request else {
      throw NetworkError.invalidRequest
    }
    
    let decodedTrackResult: Result<SearchedTrackResult, Error> = try await decodeNetworkData(with: request)
    return decodedTrackResult
  }
  
  private func decodeNetworkData<T: Decodable>(with request: URLRequest) async throws -> Result<T, Error> {
    return try await withCheckedThrowingContinuation({ [weak self] continuation in
      self?.session.getData(with: request) { data, response, error in
        guard let data = data else {
          continuation.resume(throwing: NetworkError.invalidData)
          return
        }
        
        guard let searchedTrackResult = try? JSONDecoder().decode(T.self, from: data) else {
          continuation.resume(returning: .failure(NetworkError.decodingFailure))
          return
        }
        continuation.resume(returning: .success(searchedTrackResult))
      }
    })
  }
}
