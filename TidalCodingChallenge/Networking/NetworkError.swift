//
//  NetworkError.swift
//  TidalCodingChallenge
//
//  Created by Michael Aidoo on 2022-03-12.
//

import Foundation

public enum NetworkError: Error {
  case invalidRequest
  case invalidData
  case decodingFailure
}
