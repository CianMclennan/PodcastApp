//
//  PlayerView.swift
//  PodcastApp
//
//  Created by Cian McLennan on 30/07/2020.
//

import SwiftUI
import AVKit

struct PlayerView: View {
    var title: String
    var url: URL?
    @State private var progress: Double = 0;
    @State private var playerIsPaused: Bool = true;
    let player = AudioPlayer.shared;
    
    var body: some View {
        VStack() {
            Text(title)
            PlayerProgressSliderView(player: self.player, progress: self.$progress)
            PlayerControlsView(player: self.player, isPaused: self.$playerIsPaused)
        }
        .onAppear {
            if let audioURL = self.url {
                player.replaceCurrentItem(with: AVPlayerItem(url: audioURL))
                player.play();
            }
        }
        .onReceive(player.currentTimeDidChange, perform: {
            currentTime in
            self.playerIsPaused = player.rate == 0;
            if let currentItem = player.currentItem {
                let duration = CMTimeGetSeconds(currentItem.asset.duration) as Double
                let completion = currentTime/duration
                //                print(currentTime)
                //                print(self.player.rate)
                if completion >= 0 && completion <= 1 {
                    self.progress = completion;
                }
            }
        }
        )
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(title: "Podcast Title")
    }
}
