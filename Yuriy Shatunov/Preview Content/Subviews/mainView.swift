//
//  main.swift
//  My Player
//
//  Created by Haidarov N on 15/10/24.
//

import SwiftUI

struct mainView: View {
    var body: some View {
        
            NavigationView{
                ZStack {
                    TabView{
                        songsView(song: SongModel(name: "music1" ))
                            .tabItem{
                                Image(systemName: "music.note.house")
                                    .resizable()
                                
                                Text("Songs")
                            }
                            .toolbarBackground(.visible, for: .tabBar)
                        
                        
                        about()
                            .tabItem{
                                Image(systemName: "book.pages.fill")
                                
                                Text("About")
                            }
                        
                    }
                    .background(.gray)
                    .ignoresSafeArea(.all)
                }
                
            }
        }
    }


#Preview {
    mainView()
}
