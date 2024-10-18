//
//  BackgroundView.swift
//  My Player
//
//  Created by Haidarov N on 26/09/24.
//



import SwiftUI
import Foundation



struct BackgroundView: View {
    var body: some View {
        LinearGradient(colors: [.accentColor, .accentColor], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}

