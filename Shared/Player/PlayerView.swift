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
            PlayerProgressSliderView(
                progress: self.$progress,
                onDrag: { _ in self.player.pause() },
                didFinishDrag: {value in
                    if let currentItem = player.currentItem {
                        let duration = CMTimeGetSeconds(currentItem.asset.duration) as Double
                        let newTime = value * duration;
                        seekTo(time: newTime);
                        if !self.playerIsPaused {
                            self.player.play()
                        }
                    }
                }
            )
            HStack{
                Text("10:00")
                Spacer()
                PlayerControlsView(
                    isPaused: self.$playerIsPaused,
                    seekForwardSelector: self.seekForward,
                    seekBackwardSelector:self.seekBackward,
                    togglePlayPauseSelector: self.togglePlayPause
                )
                Spacer()
                Text("00:00")
            }
            
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
                if completion >= 0 && completion <= 1 {
                    self.progress = completion;
                }
            }
        }
        )
        .padding(.horizontal)
    }
    
    func seekBackward(seconds:Double) {
        seekForward(seconds: -seconds)
    }
    func seekForward(seconds:Double) {
        let currentTime = CMTimeGetSeconds(self.player.currentTime()) as Double
        seekTo(time: currentTime+seconds)
    }
    func seekTo(time:Double) {
        player.seek(to: CMTime(seconds: time, preferredTimescale: 1));
    }
    func togglePlayPause() {
        if self.playerIsPaused {
            self.player.play()
            self.playerIsPaused = false;
        }  else {
            self.player.pause()
            self.playerIsPaused = true;
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(title: "Podcast Title")
    }
}
