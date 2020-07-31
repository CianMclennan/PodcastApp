//
//  PlayerControlsView.swift
//  PodcastApp
//
//  Created by Cian McLennan on 31/07/2020.
//

import SwiftUI
import AVKit

enum JumpTime {
    case ten, fifteen, thirty, fortyfive
}

struct PlayerControlsView: View {
    var player: AVPlayer;
    @Binding var isPaused: Bool
    var forwardTime:JumpTime = .thirty;
    var backwardTime:JumpTime = .thirty;
    
    var body: some View {
        HStack() {
            Button(action: goBack) {
                Image(systemName: "gobackward.\(timeAsInt(backwardTime))")
                    .padding(.all)
            }
            Button(action: togglePlayPause) {
                Image(systemName:
                        self.isPaused ?
                        "play.fill" :
                        "pause.fill"
                )
                    .padding(.all)
            }
            Button(action: goForward) {
                Image(systemName: "goforward.\(timeAsInt(forwardTime))")
                    .padding(.all)
            }
        }
    }
    private func timeAsInt(_ time:JumpTime) -> Int {
        switch time {
        case .ten:
            return 10
        case .fifteen:
            return 15
        case .thirty:
            return 30
        case .fortyfive:
            return 45
        }
    }
    func goBack() {
        let currentTime = CMTimeGetSeconds(self.player.currentTime()) as Double
        let skipTime:Double = Double(timeAsInt(backwardTime));
        player.seek(to: CMTime(seconds: currentTime-skipTime, preferredTimescale: 1));
    }
    func goForward() {
        let currentTime = CMTimeGetSeconds(self.player.currentTime()) as Double
        let skipTime:Double = Double(timeAsInt(forwardTime));
        player.seek(to: CMTime(seconds: currentTime+skipTime, preferredTimescale: 1));
    }
    func togglePlayPause() {
        if self.isPaused {
            self.player.play()
            self.isPaused = false;
        }  else {
            self.player.pause()
            self.isPaused = true;
        }
    }
}

struct PlayerControlsView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerControlsView(player: AVPlayer(), isPaused: .constant(true))
    }
}
