//
//  buttons.swift
//  My Player
//
//  Created by Haidarov N on 14/10/24.
//

import SwiftUI

struct buttons: View {
    @StateObject var audioPlayer = AudioPlayer()
    
    @State var playing = false
    
    @State var currentSong = ""
    
    var body: some View {
        
        HStack {
            Button(action:{
                audioPlayer.backSound()
                currentSong = audioPlayer.songName()
                playing = true
                
            }){
                
                
                Image(systemName: "backward.end.alt.fill")
            }
            
            
            
            
            
            Button(action: {
                
                playing ? audioPlayer.stopSound() : audioPlayer.playCurrentTrack()
                playing.toggle()
            }) {
                Image(systemName:  playing ? "pause.fill" :"play.fill")
            }
            
            
            
            Button(action:{
                audioPlayer.nextSound()
                
                currentSong = audioPlayer.songName()
                playing = true
            }){
                
                Image(systemName: "forward.end.alt.fill")
            }
        }
    }
}

#Preview {
    buttons()
}
