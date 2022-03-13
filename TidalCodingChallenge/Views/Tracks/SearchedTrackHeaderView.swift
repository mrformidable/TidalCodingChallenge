//
//  SearchedTrackHeaderView.swift
//  TidalCodingChallenge
//
//  Created by Michael Aidoo on 2022-03-13.
//

import SwiftUI

struct SearchedTrackHeaderView: View {
  
  let artist: Artist
  let album: Album
  
  var body: some View {
    VStack(spacing: 10) {
      
      AsyncImage(url: album.imageURL) { image in
        image.resizable()
      } placeholder: {
        Color(UIColor.systemGray5)
      }.aspectRatio(contentMode: .fit)
      
      Text(album.title)
        .font(.system(size: 19, weight: .bold))
        .lineLimit(1)
        .foregroundColor(Color.white)
      
      Text("Album by \(artist.name) >")
        .font(.system(size: 15, weight: .semibold))
        .lineLimit(1)
        .foregroundColor(Color.gray)
      
      HStack(spacing: 10) {
        Text(album.releaseDate.getAlbumReleaseYear())
          .font(.system(size: 12, weight: .bold))
          .foregroundColor(Color.gray)
        
        if album.usesExplicitLyrics {
          Text("EXPLICIT")
            .font(.system(size: 10, weight: .bold))
            .foregroundColor(.white)
            .padding(.all, 3)
            .background(Color(UIColor.darkGray))
            .cornerRadius(5)
        }
        
        Text("MASTER")
          .font(.system(size: 10, weight: .bold))
          .foregroundColor(Color.orange)
          .padding(.all, 3)
          .background(Color(UIColor.darkGray))
          .cornerRadius(5)
      }
      
      HStack(spacing: 15) {
        Button {} label: {
          HStack {
            Image(systemName: "play.fill")
              .foregroundColor(.black)
            Text("Play")
              .font(.system(size: 15, weight: .semibold))
              .foregroundColor(.black)
          }
        }
        .frame(maxWidth: 200, minHeight: 40)
        .padding(.horizontal)
        .background(Color.white)
        .cornerRadius(15)
        
        Button {} label: {
          HStack {
            Image(systemName: "shuffle")
              .foregroundColor(.white)
            Text("Shuffle")
              .font(.system(size: 15, weight: .semibold))
              .foregroundColor(Color.white)
          }
        }
        .frame(maxWidth: 200, minHeight: 40)
        .padding(.horizontal)
        .background(Color(UIColor.darkGray))
        .cornerRadius(15)
        
      }
      .padding(.top, 10)
      
      TrackPlaylistOptionsView()
        .padding(.top, 10)
    }
  }
}

struct SearchedTrackHeaderView_Previews: PreviewProvider {
  static var previews: some View {
    SearchedTrackHeaderView(artist: Artist.mock, album: Album.mock)
      .preferredColorScheme(.dark)
      .previewLayout(.fixed(width: 375, height: 400))
    TrackPlaylistOptionsView()
      .previewLayout(.sizeThatFits)
      .preferredColorScheme(.dark)
  }
}
