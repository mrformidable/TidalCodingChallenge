//
//  SearchEmptyResultsView.swift
//  TidalCodingChallenge
//
//  Created by Michael Aidoo on 2022-03-12.
//

import SwiftUI

struct SearchEmptyResultsView: View {
  
  let message: String
  
  var body: some View {
    VStack(spacing: 15) {
      Image(systemName: "magnifyingglass")
        .resizable()
        .frame(width: 100, height: 100)
        .foregroundColor(.gray)
      
      Text(message)
        .font(.system(size: 17))
        .foregroundColor(.gray)
    }
  }
}

#if DEBUG
struct SearchEmptyResultsView_Previews: PreviewProvider {
  static var previews: some View {
    SearchEmptyResultsView(message: "Empty message here..")
  }
}
#endif
