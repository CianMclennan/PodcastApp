//
//  ContentView.swift
//  Shared
//
//  Created by Cian McLennan on 29/07/2020.
//

import SwiftUI

struct PodcastsView: View {
    var podcasts: [Podcast] = []
    var body: some View {
        NavigationView {
            List(podcasts) {podcast in
                NavigationLink(
                    destination: EpisodesView(episodes: podcast.episodes)) {
                    Image(systemName: "photo")
                    VStack(alignment: .leading) {
                        Text(podcast.title)
                        Text("Number of episodes: \(podcast.episodes.count)")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Podcasts")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PodcastsView(podcasts: testData)
    }
}
