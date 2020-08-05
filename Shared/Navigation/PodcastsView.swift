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
            List(podcasts) {(podcast:Podcast) in
                if let title = podcast.title,
                   let episodes = podcast.episodes?.array as? [Episode] {
                    NavigationLink(
                        destination: EpisodesView(episodes: episodes)) {
                        Image(systemName: "photo")
                        VStack(alignment: .leading) {
                            Text(title)
                            Text("Number of episodes: \(episodes.count)")
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("Podcasts")
        }
    }
}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
////        PodcastsView(podcasts: testData)
//    }
//}
