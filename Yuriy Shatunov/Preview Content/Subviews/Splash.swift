//
//  Splash.swift
//  My Player
//
//  Created by Haidarov N on 15/10/24.
//

import SwiftUI

struct Splash: View {
    
    @State var text = false
    
    var body: some View {
        GeometryReader{ geometry in
            
            ZStack {
                Image("sh5")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .blur(radius: text ? 3: 0)
                
                
                
                
                
                
                if text{
                    Text("Юрий Шатунов")
                    
                        .foregroundColor(.orange)
                        .font(.system(size: 50))
                        .bold()
                        .padding()
                    
                    
                }
                
            }

            .frame(width: geometry.size.width, height: geometry.size.height)
            .onAppear{
                DispatchQueue.main
                    .asyncAfter(deadline: .now() + 1.5){
                        withAnimation{
                            self.text = true
                                
                            
                                
                        }
                    }
            }
        }
        .ignoresSafeArea()
        
    }
}

#Preview {
    Splash()
}
