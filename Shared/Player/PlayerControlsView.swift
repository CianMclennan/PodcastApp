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
    @Binding var isPaused: Bool
    var forwardTime:JumpTime = .thirty;
    var backwardTime:JumpTime = .thirty;
    
    var seekForwardSelector: (Double) -> Void
    var seekBackwardSelector: (Double) -> Void
    var togglePlayPauseSelector: () -> Void
    
    var body: some View {
        HStack() {
            Button(action: {
                seekBackwardSelector(timeAsDouble(backwardTime))
            }) {
                Image(systemName: "gobackward.\(Int(timeAsDouble(backwardTime)))")
            }
            .padding(.trailing)
            Button(action: self.togglePlayPauseSelector) {
                Image(systemName:
                        self.isPaused ?
                        "play.fill" :
                        "pause.fill"
                )
                .frame(width: 15.0)
                    
            }
            .padding(.horizontal)
            Button(action: {
                seekForwardSelector(timeAsDouble(forwardTime))
            }) {
                Image(systemName: "goforward.\(Int(timeAsDouble(forwardTime)))")
                    
            }
            .padding(.leading)
        }
    }
    private func timeAsDouble(_ time:JumpTime) -> Double {
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
}

struct PlayerControlsView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerControlsView(
            isPaused: .constant(true),
            seekForwardSelector: {seconds in },
            seekBackwardSelector:{seconds in },
            togglePlayPauseSelector: {}
        )
    }
}
