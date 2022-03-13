//
//  SearchedAlbumView.swift
//  TidalCodingChallenge
//
//  Created by Michael Aidoo on 2022-03-12.
//

import SwiftUI

@MainActor
struct SearchedAlbumView: View {
  private let columns = [
    GridItem(.flexible(), spacing: 20),
    GridItem(.flexible(), spacing: 20),
  ]
  
  let artist: Artist
  
  @StateObject private var viewModel = SearchedAlbumViewModel()
  
  var body: some View {
    Group {
      switch viewModel.state {
      case .loading:
        ProgressView()
          .padding(.top, 50)
          .progressViewStyle(CircularProgressViewStyle(tint: .white))
          .scaleEffect(2)
      case .emptyFetchResults:
        SearchEmptyResultsView(message: "Oops no albums found for \(artist.name)")
      case .fetchedResults(albums: let albums):
        ScrollView {
          LazyVGrid(columns: columns, spacing: 30) {
            ForEach(albums, id: \.id) { album in
              NavigationLink(destination: SearchedTracksView(album: album, artist: artist)) {
                SearchedAlbumGridView(album: album, artist: artist)
              }
            }
          }
          .padding(.top, 20)
          .padding(.horizontal)
        }
      }
    }
    .navigationTitle("\(artist.name.capitalized)'s Albums")
    .navigationBarTitleDisplayMode(.inline)
    .onLoad {
      Task {
        await viewModel.getAlbums(using: String(artist.id))
      }
    }
  }
}

#if DEBUG
struct SearchedAlbumView_Previews: PreviewProvider {
  static var previews: some View {
    SearchedAlbumView(artist: Artist.mock)
  }
}
#endif

