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
    let player = AudioPlayer.shared;
    
    var body: some View {
        VStack() {
            ProgressView(value: self.progress)
                .padding(.all)
                
            Button(action: {
                let currentTime = CMTimeGetSeconds(player.currentTime()) as Double
                player.seek(to: CMTime(seconds: currentTime+10 , preferredTimescale: 1))
                
            }) {
                Text("skip ahead 10 seconds")
                    .padding(.all)
            }
            Text(title).onAppear {
                if let audioURL = self.url {
                    player.replaceCurrentItem(with: AVPlayerItem(url: audioURL))
                    player.play();
                }
            }.onReceive(player.currentTimeUpstream, perform: {
                currentTime in
                
                    if let currentItem = player.currentItem {
                        let duration = CMTimeGetSeconds(currentItem.asset.duration) as Double
                        let completion = currentTime/duration
                        print(completion)
                        if completion >= 0 && completion <= 1 {
                            self.progress = completion;
                        }
                    }
                }
            )
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(title: "Podcast Title")
    }
}
