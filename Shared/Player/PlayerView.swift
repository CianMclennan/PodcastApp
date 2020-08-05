//
//  PlayerView.swift
//  PodcastApp
//
//  Created by Cian McLennan on 30/07/2020.
//

import SwiftUI
import AVKit

struct PlayerView: View {
    var currentEpisode: Episode
    @State var currentTime: Double = 0
    @State var duration: Double = 0
    @State private var progress: Double = 0;
    @State private var playerIsPaused: Bool = true;
    let player = AudioPlayer.shared;
    
    var body: some View {
        VStack() {
            Text(currentEpisode.title ?? "-- No Title --")
            PlayerProgressSliderView(
                progress: self.$progress,
                onDrag: { _ in
                    self.player.pause()
                },
                didFinishDrag: {value in
                    if let currentItem = player.currentItem {
                        let duration = CMTimeGetSeconds(currentItem.asset.duration) as Double
                        let newTime = value * duration;
                        seekTo(time: newTime);
                        self.player.play()
                    }
                }
            )
            HStack{
                Text(formatTime(seconds: self.currentTime))
                Spacer()
                PlayerControlsView(
                    isPaused: self.$playerIsPaused,
                    seekForwardSelector: self.seekForward,
                    seekBackwardSelector:self.seekBackward,
                    togglePlayPauseSelector: self.togglePlayPause
                )
                Spacer()
                Text(formatTime(seconds: self.duration))
            }
            
        }
        .onAppear {
            if let audioURL = self.currentEpisode.content_url {
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
                    self.duration = duration;
                    self.currentTime = currentTime;
                    self.progress = completion;
                }
            }
        }
        )
        .padding(.horizontal)
    }
    func formatTime(seconds: Double) -> String {
        let secsInt = Int(seconds);
        var time = [
            secsInt / 3600,
            (secsInt % 3600) / 60,
            (secsInt % 3600) % 60
        ]
        if(time[0] == 0) {
            // remove hours if it is 0
            time = Array(time[1..<time.count])
        }
        return time.map { (timeUnit) -> String in
            // make sure there is at least 2 characters for every unit.
            timeUnit < 10 ? "0\(timeUnit)" : "\(timeUnit)"
        }.joined(separator: ":");
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

//struct PlayerView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayerView()
//    }
//}
