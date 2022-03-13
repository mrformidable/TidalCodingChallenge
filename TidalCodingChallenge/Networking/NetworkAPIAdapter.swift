//
//  NetworkAPIAdapter.swift
//  TidalCodingChallenge
//
//  Created by Michael Aidoo on 2022-03-12.
//

import Foundation

public enum NetworkAPIAdapter {
  case albums(String)
  case tracks(String)
  case artistSearch(String)
  
  internal var baseURL: String {
    "http://api.deezer.com"
  }
  
  internal var path: String {
    switch self {
    case .albums(let artistId):
      return "/artist/\(artistId)/albums"
    case .tracks(let albumId):
      return "/album/\(albumId)/tracks"
    case .artistSearch:
      return "/search/artist"
    }
  }
  
  private var queryItems: [URLQueryItem]? {
    switch self {
    case .artistSearch(let query):
      return [URLQueryItem(name: "q", value: query)]
    default:
      return nil
    }
  }
  
  internal var urlComponents: URLComponents? {
    var components = URLComponents(string: baseURL)
    components?.path = path
    components?.queryItems = queryItems
    return components
  }
  
  public var request: URLRequest? {
    guard let urlComponents = urlComponents,
          let url = urlComponents.url else {
            return nil
          }
    return URLRequest(url: url)
  }
  
}
