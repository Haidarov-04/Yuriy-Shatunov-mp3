//
//  settings.swift
//  My Player
//
//  Created by Haidarov N on 09/10/24.
//

import SwiftUI

struct about: View {
    @Binding var currentDetend:PresentationDetent
    var body: some View {
        ZStack {
            LinearGradient(colors: [.purple, .orange], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                VStack{
                    Text("Music Player")
                    Text("Юрий Шатуров")
                }
                .font(.title)
                .padding()
                .foregroundColor(.white)
                Spacer()
                Spacer()
                
            }
        }
        .onAppear(){
            currentDetend = .height(80)
        }
    }
}


