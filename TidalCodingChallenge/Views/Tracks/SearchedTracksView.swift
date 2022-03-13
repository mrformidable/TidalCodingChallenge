//
//  SearchedTracksView.swift
//  TidalCodingChallenge
//
//  Created by Michael Aidoo on 2022-03-13.
//

import SwiftUI

struct SearchedTracksView: View {
  
  @StateObject private var viewModel = SearchedTracksViewModel()
  
  let album: Album
  let artist: Artist
  
  var body: some View {
    List {
      Section {
        SearchedTrackHeaderView(artist: artist, album: album)
      }
      
      ForEach(viewModel.tracks, id: \.id) { track in
        SearchedTracksCellView(track: track, artist: artist)
          .padding(.vertical, 5)
      }
    }
    .listStyle(.plain)
    .onAppear {
      Task {
        await viewModel.getTracks(using: String(album.id))
      }
    }
  }
}

#if DEBUG
struct SearchedTracksView_Previews: PreviewProvider {
  static var previews: some View {
    SearchedTracksView(album: Album.mock, artist: Artist.mock)
  }
}
#endif
