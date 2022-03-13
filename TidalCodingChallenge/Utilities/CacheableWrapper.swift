//
//  CacheableWrapper.swift
//  TidalCodingChallenge
//
//  Created by Michael Aidoo on 2022-03-12.
//

import Foundation

class CacheableWrapper<T> {
  
  let value: T
  
  init(_ wrappedStruct: T) {
    self.value = wrappedStruct
  }
}
