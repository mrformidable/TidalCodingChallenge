//
//  SearchArtistCellView.swift
//  TidalCodingChallenge
//
//  Created by Michael Aidoo on 2022-03-12.
//

import SwiftUI

struct SearchArtistCellView: View {
  
  let artist: Artist
  
  var body: some View {
    HStack(spacing: 15) {
      AsyncImage(url: artist.thumbnailURL) { image in
        artistImageStyle(image: image)
      } placeholder: {
        artistImageStyle(image: Image(systemName: "person.crop.circle"))
      }
      Text(artist.name)
        .font(.system(size: 16, weight: .semibold))
    }.padding(.vertical, 5)
  }
  
  private func artistImageStyle(image: Image) -> some View {
    image
      .resizable()
      .frame(width: 60, height: 60)
      .tint(Color.gray)
      .cornerRadius(30)
  }
}

#if DEBUG
struct SearchArtistCellView_Previews: PreviewProvider {
  static var previews: some View {
    SearchArtistCellView(artist: Artist.mock)
  }
}
#endif
