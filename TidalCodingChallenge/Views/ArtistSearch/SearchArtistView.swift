//
//  SearchArtistView.swift
//  TidalCodingChallenge
//
//  Created by Michael Aidoo on 2022-03-12.
//

import SwiftUI

struct SearchArtistView: View {
  
  @StateObject var viewModel = SearchArtistViewModel()
  
  var body: some View {
    NavigationView {
      Group {
        switch viewModel.state {
        case .emptyQuery:
          SearchEmptyResultsView(message: "Search for your favorite artists")
        case .emptySearchedResults(let query):
          SearchEmptyResultsView(message: "No search results for \(query)")
        case .searchFailure:
          SearchEmptyResultsView(message: "Oops an error occurred, please try again.")
        case .fetchedResults(artists: let artists):
          List(artists, id: \.id) { artist in
            NavigationLink(destination: SearchedAlbumView(artist: artist)) {
              SearchArtistCellView(artist: artist)
            }
          }
          .listStyle(.plain)
        }
      }
      .searchable(text: $viewModel.searchQuery, prompt: "Search")
      .navigationTitle("Artists")
    }
  }
}

#if DEBUG
struct SearchArtistView_Previews: PreviewProvider {
  static var previews: some View {
    SearchArtistView()
      .preferredColorScheme(.dark)
  }
}
#endif
