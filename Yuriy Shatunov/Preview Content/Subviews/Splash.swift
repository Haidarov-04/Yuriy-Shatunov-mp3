//
//  Splash.swift
//  My Player
//
//  Created by Haidarov N on 15/10/24.
//

import SwiftUI

struct Splash: View {
    var body: some View {
        
        ZStack {
            Color.blue
            Text("Haidarov's demo")
                
                .font(.largeTitle)
                .foregroundColor(.white)
                
        }
        .ignoresSafeArea(.all)
        
    }
}

#Preview {
    Splash()
}
