//
//  ContentView.swift
//  Gruppa IQBOL
//
//  Created by Haidarov N on 24/09/24.
//

import SwiftUI

struct ContentView: View {
    @State private var splash = true
    
    
    var body: some View {
        
        NavigationView{
            
            
            if splash{
                ZStack{
                    
                    
                    Splash()
                        .transition(.opacity)
                        .animation(.easeOut(duration: 1.5))
                    
                }
                .onAppear{
                    DispatchQueue.main
                        .asyncAfter(deadline: .now() + 3){
                            withAnimation{
                                self.splash = false
                            }
                        }
                }
                
            }else{
                VStack{
                    mainView()
                }
                
                
            }
            
            
            
            
            
            
            
        }
        
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ContentView()
}


        
        
        
        
        
        
        




        
        
        



