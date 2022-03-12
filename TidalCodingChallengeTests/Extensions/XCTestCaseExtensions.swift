//
//  XCTestCaseExtensions.swift
//  TidalCodingChallengeTests
//
//  Created by Michael Aidoo on 2022-03-12.
//

import Foundation
import XCTest

extension XCTestCase {
  enum FileExtension {
    case json
    
    var name: String {
      switch self {
      case .json:
        return "json"
      }
    }
  }
  
  func getTestData(filename: String, extensionType: FileExtension = .json) -> Data? {
    let bundle = Bundle(for: type(of: self))
    guard let filePath = bundle.url(forResource: filename, withExtension: extensionType.name) else {
      return nil
    }
    return try? Data(contentsOf: filePath)
  }
}
