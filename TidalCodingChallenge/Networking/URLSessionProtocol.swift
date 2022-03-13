//
//  URLSessionProtocol.swift
//  TidalCodingChallenge
//
//  Created by Michael Aidoo on 2022-03-12.
//

import Foundation

protocol URLSessionProtocol {
  func getData(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
}

extension URLSession: URLSessionProtocol {
  
  func getData(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
    let task = dataTask(with: request) { data, response, error in
      completionHandler(data, response, error)
    }
    task.resume()
  }
}
