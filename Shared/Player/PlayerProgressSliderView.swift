//
//  PlayerProgressSliderView.swift
//  PodcastApp
//
//  Created by Cian McLennan on 31/07/2020.
//

import SwiftUI
import AVKit
import Sliders

struct PlayerProgressSliderView: View {
    let player: AVPlayer
    @Binding var progress: Double;
    
    var body: some View {
        ValueSlider(value: self.$progress,
            onEditingChanged:{ isBeingDraged in
                player.pause();
                if(!isBeingDraged) {
                    if let currentItem = player.currentItem {
                        let duration = CMTimeGetSeconds(currentItem.asset.duration) as Double
                        let newTime = self.progress * duration;
                        self.player.seek(to: CMTime(seconds: newTime, preferredTimescale: 1))
                        self.player.play()
                    }
                }
            })
            .padding(.horizontal)
            .frame(height: 16.0)
            .valueSliderStyle(
                HorizontalValueSliderStyle(
                    thumbSize: CGSize(width: 32, height: 16)
                    
                )
            )
    }
}

struct PlayerProgressSliderView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerProgressSliderView(player: AVPlayer(), progress: .constant(0))
    }
}
