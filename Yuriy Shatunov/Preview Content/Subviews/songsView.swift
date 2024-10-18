//
//  songsView.swift
//  My Player
//
//  Created by Haidarov N on 09/10/24.
//

import SwiftUI

struct songsView: View {
    @StateObject var vm = ViewModel()
    @State var isPresented: Bool = true
    @State var height: CGFloat = 80
    
    @StateObject var audioPlayer = AudioPlayer()
    
    @State var playing = false
    
    let song: SongModel
    
    @State var currentSong = "Седач ночь"
    
    

   

    
    

    var body: some View {
        NavigationStack{
            ZStack{
                BackgroundView()
                //            ScrollView{
                
                ScrollView{
                    ForEach(vm.songs.indices, id: \.self) { i in
                        HStack{
                            SongCell(song: vm.songs[i])
                                .onTapGesture {
                                    
                                    isPresented = true
                                    
                                    
                                    audioPlayer.playSound(named: vm.songs[i].name)
                                    
                                    
                                    if vm.songs[i].name == audioPlayer.soundFiles.songs[i].name {
                                        audioPlayer.currentTrackIndex = i
                                    }

                                   
                                    playing = true
                                    currentSong = vm.songs[i].name
                                  
                                }
                                
                        }
                        .padding()
                        .overlay(
                                  Rectangle()
                                      .frame(height: 2)
                                    .foregroundColor(.gray.opacity(0.4))
                                      .padding(.top, 50),
                                  alignment: .bottom
                              )
                    
                    }

                            
                            
                            
                
                }
                
                
                .listStyle(.plain)
                //            }
            }
            .sheet(isPresented: $isPresented){
                NavigationView{
                   
                        
                                VStack{
                                   
                                    HStack {
                                        
                                        if height==770{
                                            
                                        
                                            HStack {
                                                Button(action:{
                                                    height = 80
                                                }){
                                                    Image(systemName: "chevron.down")
                                                    
                                                }.frame(width: 40, height: 40, alignment: .topLeading)
                                                Spacer()
                                            }
                                                
                                            
                                            
                                        }else{
                                        
                                        HStack{
                                            Image("sh")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                                .cornerRadius(50)
                                                .shadow(color: .blue, radius: 20)
                                            
                                            
                                            VStack{
                                                Text(currentSong)
                                                
                                            }
                                            Spacer()
                                            
                                            
//                                            buttons()
                                            HStack {
                                                Button(action:{
                                                    audioPlayer.backSound()
                                                    currentSong = audioPlayer.songName()
                                                    playing = true
                                                    
                                                }){
                                                    
                                                    
                                                    Image(systemName: "backward.end.alt")
                                                        .shadow(color: .black, radius: 20)
                                                }
                                                
                                                
                                                
                                                
                                                
                                                Button(action: {
                                                    
                                                    playing ? audioPlayer.stopSound() : audioPlayer.playCurrentTrack()
                                                    playing.toggle()
                                                }) {
                                                    Image(systemName:  playing ? "pause" :"play")
                                                        .shadow(color: .black, radius: 20)
                                                }
                                                
                                                
                                                
                                                Button(action:{
                                                    audioPlayer.nextSound()
                                                    
                                                    currentSong = audioPlayer.songName()
                                                    playing = true
                                                }){
                                                    
                                                    Image(systemName: "forward.end.alt")
                                                        .shadow(color: .black, radius: 20)
                                                }
                                            }
                                            .foregroundColor(.white)
                                            
                                            
                                            
                                            
                                            VStack{
                                                Text("03:20")
                                            }
                                            
                                        }
                                        .ignoresSafeArea()
                                        .listRowBackground(Color.clear)
                                        .onTapGesture {
                                            height = 770
                                            
                                        }
                                        }
                                    }
                                       
                                    
                                    
                                    
                                   
                                    if height >= 81{
                                        VStack{
                                            
                                            
                                            Image("sh")
                                                .resizable()
                                                .frame(width: 200 , height: 200)
                                                .cornerRadius(40)
                                                .shadow(color: .black, radius: 20)
                                            
                                            
                                            
                                            
                                            
                                            Text(currentSong)
                                                .font(.largeTitle)
                                            Text("Юрий Шатунов")
                                                .font(.title)
                                            
                                            
                                            
                                            
                                            
                                            HStack {
                                                
                                                Button(action:{
                                                    audioPlayer.backSound()
                                                    currentSong = audioPlayer.songName()
                                                    playing = true
                                                }){
                                                   Image(systemName: "backward.end.alt")
                                                        .foregroundColor(.white)
                                                        .font(.largeTitle)
                                                        .shadow(color: .black, radius: 20)
                                                }
                                                
                                                Spacer()
                                                Button(action: {
                                                    playing ? audioPlayer.stopSound() : audioPlayer.playCurrentTrack()
                                                    playing.toggle()
                                                    audioPlayer.startMusicTimer()
                                                }) {
                                                    Image(systemName:  playing ? "pause" :"play")
                                                        .foregroundColor(.white)
                                                        .font(.largeTitle)
                                                        .shadow(color: .black, radius: 20)
                                                }
                                                
                                                Spacer()
                                                
                                                Button(action:{
                                                    audioPlayer.nextSound()
                                                    
                                                    currentSong = audioPlayer.songName()
                                                    playing = true
                                                    
                                                }){
                                                    Image(systemName: "forward.end.alt")
                                                        .foregroundColor(.white)
                                                        .font(.largeTitle)
                                                        .shadow(color: .black, radius: 20)
                                                }
                                                
                                            }
                                            
                                            .padding(.horizontal)
                                            .padding(.top)
                                            
                                            HStack {
                                                Text(audioPlayer.formatTime(audioPlayer.musicCurrentTime))
                                                
                                                
                                                Slider(value: Binding(
                                                    get: {
                                                        audioPlayer.musicCurrentTime
                                                    },
                                                    set: { (newValue) in
                                                        audioPlayer.musicCurrentTime = newValue
                                                        audioPlayer.player?.currentTime = newValue
                                                    }
                                                ), in: 0...audioPlayer.musicDuration)
                                                .padding()

                                                Text(audioPlayer.formatTime(audioPlayer.musicDuration))
                                                    .onAppear {
                                                        audioPlayer.startMusicTimer()
                                                    }
                                                
                                                
                                            }
                                            
                                            HStack{
                                                
                                                
                                              
                                            }
                                            

                                        }
                                        .onAppear {
                                            
                                            
                                        }
                                    }
                                    
                                    
                                    
                                    Spacer()
                                }
                                
                                .padding()
                                
                                
                                
                                    
                        
                }
                .background( LinearGradient(colors: [.purple, .accentColor], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea())
                .presentationDetents([.height(height), .large])
                .presentationCornerRadius(20)
                .presentationBackground(.regularMaterial)
                .presentationBackgroundInteraction(.enabled(upThrough: .large))
                .interactiveDismissDisabled()
                .bottomMaaskForSheet()
            }
            
                    
        }
        

            .toolbar{
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "plus")
                            .font(.title2)
                    }
                }
            }
            
        
    }
}

#Preview {
    songsView(song: SongModel(name: "music1"))
}


