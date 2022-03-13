//
//  SearchedTracksCellView.swift
//  TidalCodingChallenge
//
//  Created by Michael Aidoo on 2022-03-13.
//

import SwiftUI

struct SearchedTracksCellView: View {
  
  let track: Track
  let artist: Artist
  
  var body: some View {
    HStack {
      Text(String(track.position))
        .font(.system(size: 16, weight: .bold))
        .foregroundColor(Color.gray)
        .padding(.horizontal, 5)
      
      VStack(alignment: .leading, spacing: 5) {
        HStack {
          Text(track.title)
            .font(.system(size: 17, weight: .bold))
            .lineLimit(1)
            .foregroundColor(Color.white)
          
          Text("M")
            .font(.system(size: 7, weight: .bold))
            .foregroundColor(Color.orange)
            .padding(.vertical, 2)
            .padding(.horizontal, 4)
            .background(Color(UIColor.darkGray))
            .cornerRadius(3)
        }
        HStack {
          if track.usesExplicitLyrics {
            Text("E")
              .font(.system(size: 7, weight: .bold))
              .foregroundColor(Color.white)
              .padding(.vertical, 2)
              .padding(.horizontal, 4)
              .background(Color(UIColor.darkGray))
              .cornerRadius(3)
          }
          
          Text(artist.name)
            .font(.system(size: 15, weight: .bold))
            .lineLimit(1)
            .foregroundColor(Color.gray)
        }
      }
      
      Spacer()
      
      Button { } label: {
        Image("more-icon")
          .tint(.white)
      }
    }
  }
}

#if DEBUG
struct SearchedTracksCellView_Previews: PreviewProvider {
  static var previews: some View {
    SearchedTracksCellView(track: Track.mock, artist: Artist.mock)
      .preferredColorScheme(.dark)
      .previewLayout(.sizeThatFits)
  }
}
#endif
