//
//  airPlay.swift
//  Yuriy Shatunov
//
//  Created by Haidarov N on 23/10/24.
//

import SwiftUI
import AVFoundation
import MediaPlayer
import AVKit

//airPlay
struct RouteButtonView: UIViewRepresentable {
    func makeUIView(context: Context) -> AVRoutePickerView {
        let routePickerView = AVRoutePickerView()
        routePickerView.tintColor = .red
        return routePickerView
    }
    
    func updateUIView(_ uiView: AVRoutePickerView, context: Context) {
        
    }
}
