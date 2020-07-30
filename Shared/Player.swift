//
//  Player.swift
//  PodcastApp
//
//  Created by Cian McLennan on 30/07/2020.
//

import AVKit


import Combine // for observing and adding as environmentObject

final class AudioPlayer: AVPlayer, ObservableObject {

    var currentTimeUpstream = PassthroughSubject<Double, Never>()
    var timeObserverToken: Any?
    
    static let shared = AudioPlayer();
    
    private override init() {
        super.init()
        let timeScale = CMTimeScale(NSEC_PER_SEC)
            let time = CMTime(seconds: 0.5, preferredTimescale: timeScale)

            timeObserverToken = self.addPeriodicTimeObserver(forInterval: time,
                                                              queue: .main) {
                [weak self] time in
                if let player = self
                {
                    let currentTime = CMTimeGetSeconds(player.currentTime()) as Double
                    self?.currentTimeUpstream.send(currentTime);
                }
            }
        
    }
}
