//
//  volumeSlider.swift
//  Yuriy Shatunov
//
//  Created by Haidarov N on 23/10/24.
//

import SwiftUI
import AVFoundation
import MediaPlayer
import AVKit

//volume slider
struct VolumeSliderView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> MPVolumeView {
        let volumeView = MPVolumeView()
        volumeView.showsVolumeSlider = true
        volumeView.tintColor = .white
        return volumeView
    }
    
    func updateUIView(_ uiView: MPVolumeView, context: Context) {
        
    }
    
}



