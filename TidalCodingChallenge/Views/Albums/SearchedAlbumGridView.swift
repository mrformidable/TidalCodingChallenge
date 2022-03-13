//
//  SearchedAlbumGridView.swift
//  TidalCodingChallenge
//
//  Created by Michael Aidoo on 2022-03-13.
//

import SwiftUI

struct SearchedAlbumGridView: View {
  
  let album: Album
  let artist: Artist
  
  var body: some View {
    VStack(alignment: .leading, spacing: 5) {
      AsyncImage(url: album.imageURL) { image in
        image.resizable()
      } placeholder: {
        Color(UIColor.systemGray5)
      }.aspectRatio(contentMode: .fit)
      
      Text(album.title)
        .font(.system(size: 17, weight: .bold))
        .foregroundColor(.white)
        .lineLimit(1)
        .padding(.top, 5)
      
      Text(artist.name.capitalized)
        .font(.system(size: 15, weight: .bold))
        .lineLimit(1)
        .foregroundColor(Color.gray)
      
      HStack {
        Text(album.releaseDate.getAlbumReleaseYear())
          .font(.system(size: 10, weight: .bold))
          .foregroundColor(Color.gray)
        
        if album.usesExplicitLyrics {
          Text("EXPLICIT")
            .font(.system(size: 8, weight: .bold))
            .foregroundColor(.white)
            .padding(.all, 3)
            .background(Color(UIColor.darkGray))
            .cornerRadius(5)
        }
        
        Text("MASTER")
          .font(.system(size: 8, weight: .bold))
          .foregroundColor(Color.orange)
          .padding(.all, 3)
          .background(Color(UIColor.darkGray))
          .cornerRadius(5)
      }
    }
  }
}

#if DEBUG
struct SearchedAlbumGridView_Previews: PreviewProvider {
  static var previews: some View {
    SearchedAlbumGridView(album: Album.mock, artist: Artist.mock)
      .preferredColorScheme(.dark)
      .previewLayout(.fixed(width: /*@START_MENU_TOKEN@*/300.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/300.0/*@END_MENU_TOKEN@*/))
  }
}
#endif
