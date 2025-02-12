//
//  songsView.swift
//  My Player
//
//  Created by Haidarov N on 09/10/24.
//

import SwiftUI
import MediaPlayer
import AVFoundation
import UIKit


struct songsView: View{
    @State var isPresented: Bool = true
    @State var height: CGFloat = 80
    @ObservedObject var audioPlayer = AudioPlayer()
    @State var playing = false
    @State var currentSong = "Седая ночь"
    @State var dur = true
    @Binding var currentDetend:PresentationDetent
    @State  var isLargeDetent = false
    var body: some View {
        GeometryReader{ geometry in
            NavigationStack{
                ZStack{
                    Image("sh5")
                        .resizable()
                        .ignoresSafeArea()
                        .blur(radius: 30)
                    
                    LinearGradient(colors: [.accentColor, .accentColor], startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()
                        .opacity(0.4)
                    ScrollView{
                        ForEach(audioPlayer.soundFiles.songs.indices, id: \.self) { i in
                            HStack{
                                SongCell(song: audioPlayer.soundFiles.songs[i])
                                    .onTapGesture {
                                        isPresented = true
                                        audioPlayer.playSound(named: audioPlayer.soundFiles.songs[i].name)
                                        audioPlayer.currentTrackIndex = i
                                        playing = true
                                        currentSong = audioPlayer.soundFiles.songs[i].name
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
                    .padding(.bottom, 70)
                    .onAppear{
                        audioPlayer.durationMusic()
                        dur = false
                    }
                }
                .sheet(isPresented: $isPresented){
                    NavigationView{
                        ZStack {
                            VStack{
                                HStack {
                                    if !isLargeDetent{
                                        HStack{
                                            Image("sh1")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                                .cornerRadius(50)
                                                .shadow(color: .blue, radius: 20)
                                            VStack{
                                                audioPlayer.songName()
                                                
                                            }
                                            Spacer()
                                            HStack {
                                                Button(action:{
                                                    perviousSound()
                                                    
                                                }){
                                                    Image(systemName: "backward")
                                                        .shadow(color: .black, radius: 20)
                                                }
                                                Button(action: {
                                                    playStopSound()
                                                }) {
                                                    Image(systemName:  playing ? "pause" :"play")
                                                        .shadow(color: .black, radius: 20)
                                                }
                                                Button(action:{
                                                    nextSound()
                                                }){
                                                    Image(systemName: "forward")
                                                        .shadow(color: .black, radius: 20)
                                                }
                                            }
                                            .foregroundColor(.white)
                                            VStack{
                                                Text(audioPlayer.formatTime(audioPlayer.musicDuration-audioPlayer.musicCurrentTime))
                                            }
                                            
                                        }
                                        .ignoresSafeArea()
                                        .listRowBackground(Color.clear)
                                    }
                                }
                                if (isLargeDetent){
                                    ZStack {
                                        BackgroundView()
                                        VStack{
                                            Image("sh1")
                                                .resizable()
                                                .frame(width: geometry.size.width*0.6 , height: geometry.size.height*0.303)
                                                .cornerRadius(40)
                                                .shadow(color: .black, radius: 20)
                                            audioPlayer.songName()
                                                .font(.title)
                                            Text("Юрий Шатунов")
                                                .font(.title)
                                            VStack {
                                                VStack{
                                                    HStack {
                                                        Slider(value: Binding(
                                                            get: {
                                                                audioPlayer.musicCurrentTime
                                                            },
                                                            set: { (newValue) in
                                                                audioPlayer.musicCurrentTime = newValue
                                                                audioPlayer.player?.currentTime = newValue
                                                            }
                                                        ), in: 0...audioPlayer.musicDuration)
                                                        .tint(.white)
                                                        .cornerRadius(10)
                                                    }
                                                    HStack {
                                                        Text(audioPlayer.formatTime(audioPlayer.musicCurrentTime))
                                                        Spacer()
                                                        Text(audioPlayer.formatTime(audioPlayer.musicDuration))
                                                    }
                                                    .foregroundColor(.white)
                                                    
                                                }
                                                .padding(.horizontal)
                                            }
                                            HStack {
                                                Button(action:{
                                                    perviousSound()
                                                }){
                                                    Image(systemName: "backward.fill")
                                                        .foregroundColor(.white)
                                                        .font(.largeTitle)
                                                        .shadow(color: .black, radius: 20)
                                                }
                                                Spacer()
                                                Button(action: {
                                                    playStopSound()
                                                }) {
                                                    Image(systemName:  playing ? "pause.fill" :"play.fill")
                                                        .foregroundColor(.white)
                                                        .font(.largeTitle)
                                                        .shadow(color: .black, radius: 20)
                                                }
                                                Spacer()
                                                Button(action:{
                                                    nextSound()
                                                }){
                                                    Image(systemName: "forward.fill")
                                                        .foregroundColor(.white)
                                                        .font(.largeTitle)
                                                        .shadow(color: .black, radius: 20)
                                                }
                                            }
                                            .padding()
                                            HStack {
                                                VolumeSliderView()
                                                    .frame(width: 300, height: 50)
                                                    .padding(.top)
                                                    .cornerRadius(10)
                                            }
                                            HStack {
                                                RouteButtonView()
                                                    .frame(width: 50, height: 50)
                                                    .padding(.horizontal)
                                                    .cornerRadius(10)
                                                Spacer()
                                                Button(action: {
                                                    isLargeDetent = false
                                                    height = 80
                                                    currentDetend = .height(height)
                                                }){
                                                    Image(systemName: "list.bullet")
                                                        .foregroundColor(.red)
                                                        .font(.system(size: 30))
                                                        .padding(.horizontal)
                                                }
                                            }
                                        }
                                    }
                                }
                                Spacer()
                            }
                            .padding()
                        }
                    }
                    .background( LinearGradient(colors: [.purple, .accentColor], startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea())
                    .presentationDetents([.height(height), .large], selection: $currentDetend)
                    .presentationCornerRadius(20)
                    .presentationBackground(.regularMaterial)
                    .presentationBackgroundInteraction(.enabled(upThrough: .large))
                    .interactiveDismissDisabled()
                    .bottomMaaskForSheet()
                    .onChange(of: currentDetend) { newDetent in
                        isLargeDetent = (newDetent == .large)
                    }
                }
            }
        }
        .toolbar{
            ToolbarItem(placement: .topBarTrailing) {
                Text("Shatunov")
                    .font(.largeTitle)
            }
        }
    }
    
    func nextSound(){
        audioPlayer.nextSound()
        playing = true
    }
    
    func perviousSound(){
        audioPlayer.backSound()
        playing = true
    }
    
    func playStopSound(){
        playing ? audioPlayer.stopSound() : audioPlayer.playCurrentTrack()
        playing.toggle()
    } 
}





