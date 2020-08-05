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
        
        List(episodes) { (episode:Episode) in
            if let title = episode.title {
                NavigationLink(
                    destination: PlayerView(
                        currentEpisode: episode
                ))
                {
                    Text(title)
                }
            }
        }.navigationTitle("Episodes")
    }
}

struct EpisodesView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodesView(episodes: [])
    }
}
