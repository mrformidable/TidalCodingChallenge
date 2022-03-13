//
//  TrackPlaylistOptionsView.swift
//  TidalCodingChallenge
//
//  Created by Michael Aidoo on 2022-03-13.
//

import SwiftUI

struct TrackPlaylistOptionsView: View {
  
  var body: some View {
    HStack(spacing: 35) {
      VStack {
        Button {} label: {
          VStack(spacing: 8) {
            Image(systemName: "heart")
              .tint(.white)
            Text("Add")
              .font(.system(size: 12, weight: .semibold))
          }
        }
      }
      
      VStack {
        Button {} label: {
          VStack(spacing: 8) {
            Image(systemName: "info.circle")
              .tint(.white)
            Text("Info")
              .font(.system(size: 12, weight: .semibold))
          }
        }
      }
      
      VStack {
        Button {} label: {
          VStack(spacing: 8) {
            Image(systemName: "arrow.down.circle")
              .tint(.white)
            Text("Download")
              .font(.system(size: 12, weight: .semibold))
          }
        }
      }
      
      VStack {
        Button {} label: {
          VStack(spacing: 8) {
            Image(systemName: "square.and.arrow.up")
              .tint(.white)
            Text("Share")
              .font(.system(size: 12, weight: .semibold))
          }
        }
      }
      
    }
  }
}

struct TrackPlaylistOptionsView_Previews: PreviewProvider {
  static var previews: some View {
    TrackPlaylistOptionsView()
  }
}
