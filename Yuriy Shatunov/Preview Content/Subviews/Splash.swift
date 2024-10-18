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
            Text("Юрий Шатунов")
                
                .font(.largeTitle)
                .foregroundColor(.white)
                
        }
        .ignoresSafeArea(.all)
        
    }
}

#Preview {
    Splash()
}
