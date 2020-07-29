//
//  ContentView.swift
//  Shared
//
//  Created by Cian McLennan on 29/07/2020.
//

import SwiftUI

struct ContentView: View {
    var podcasts: [Podcast] = []
    var body: some View {
        NavigationView {
            List(podcasts) {podcast in
                NavigationLink(
                    destination: List(podcast.episodes) { episode in
                        Text(episode.title)
                    }.navigationTitle("Episodes")) {
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
        ContentView(podcasts: testData)
    }
}
