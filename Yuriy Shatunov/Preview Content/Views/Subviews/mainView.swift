//
//  main.swift
//  My Player
//
//  Created by Haidarov N on 15/10/24.
//

import SwiftUI



struct mainView: View {
    @State var currentDetend:PresentationDetent = .height(80)
    var body: some View {
        NavigationView{
            ZStack {
                TabView{
                    songsView(currentDetend: $currentDetend)
                        .tabItem{
                            Image(systemName: "music.note.house")
                                .resizable()
                            Text("Songs")
                        }
                        .toolbarBackground(.visible, for: .tabBar)
                    about(currentDetend: $currentDetend)
                        .tabItem{
                            Image(systemName: "gear")
                            Text("About")
                        }
                        
                        
                }
                .ignoresSafeArea(.all)
            }
            
        }
    }
}


#Preview {
    mainView()
}
