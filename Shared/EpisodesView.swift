//
//  EpisodesView.swift
//  PodcastApp
//
//  Created by Cian McLennan on 30/07/2020.
//

import SwiftUI

struct EpisodesView: View {
    var episodes:[Episode]
    var body: some View {
        
        List(episodes) { episode in
            NavigationLink(
                destination: PlayerView(
                    title: episode.title,
                    url: URL(string: episode.audioURL)!)
            )
            {
                Text(episode.title)
            }
        }.navigationTitle("Episodes")
    }
}

struct EpisodesView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodesView(episodes: [Episode(title: "title", description: "description", imageURL: "", audioURL: "")])
    }
}
