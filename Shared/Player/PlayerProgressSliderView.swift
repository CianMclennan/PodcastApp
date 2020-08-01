//
//  PlayerProgressSliderView.swift
//  PodcastApp
//
//  Created by Cian McLennan on 31/07/2020.
//

import SwiftUI
import AVKit
import Sliders

var isUpdating:Bool = false;

struct PlayerProgressSliderView: View {
    @Binding var progress: Double;
    var onDrag: (Double) -> Void = {_ in }
    var didFinishDrag: (Double) -> Void = {_ in }
    
    var body: some View {
        VStack {
            ValueSlider(value: self.$progress,
                onEditingChanged:{ isBeingDraged in
                    isBeingDraged ?
                        onDrag(self.progress):
                        didFinishDrag(self.progress)
                })
            .frame(height: 5.0)
            .valueSliderStyle(
                HorizontalValueSliderStyle(
                    thumbSize: CGSize(width: 32, height: 16)
                    
                )
            )            
        }
    }
}

struct PlayerProgressSliderView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerProgressSliderView(progress: .constant(0))
            .padding(.horizontal)
    }
}
