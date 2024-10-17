//
//  SongCell.swift
//  My Player
//
//  Created by Haidarov N on 26/09/24.
//

import SwiftUI

struct SongCell: View {
    
    let song: SongModel
    
    @StateObject var audioPlayer = AudioPlayer()
    var body: some View {
        HStack{
            Image("sh")
                .resizable()
                .frame(width: 50, height: 50)
                .cornerRadius(50)
                .shadow(color: .red, radius: 20)
            VStack{
                Text(song.name)
                
            }
            Spacer()
            VStack{
                
            }
            
        }
        .ignoresSafeArea()
        .listRowBackground(Color.clear)
    }
}





#Preview {
    SongCell(song: SongModel(name: "Vechera"))
}
