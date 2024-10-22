//
//  PlayerModel.swift
//  My Player
//
//  Created by Haidarov N on 12/10/24.
//
import SwiftUI
import AVFoundation
import MediaPlayer
import AVKit



class AudioPlayer: ObservableObject {
    var player: AVAudioPlayer?
    @StateObject var soundFiles = ViewModel()
    var currentTrackIndex = 0
    @State var isPlaying: Bool = false
    
    
    @Published var musicCurrentTime: TimeInterval = 0.0
    @Published var musicDuration: TimeInterval = 0.0
    
   

    @State  var timer: Timer?
    
  
   
    
  
    
    
    //play music
    func playSound(named soundName: String) {
        
        
        
        do {
               
               try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
               try AVAudioSession.sharedInstance().setActive(true)
           } catch {
               print("Ошибка настройки аудиосессии: \(error.localizedDescription)")
           }
       
        if let bundlePath = Bundle.main.resourcePath {
            do {
                let fileList = try FileManager.default.contentsOfDirectory(atPath: bundlePath)
                print("Файлы в бандле: \(fileList)")
                
              
            } catch {
                print("Не удалось получить список файлов в бандле: \(error)")
            }
        }
        
        

        
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else {
            print("Файл не найден: \(soundName).mp3")
            return
        }

        do {
            
            player = try AVAudioPlayer(contentsOf: url)
            
            player?.prepareToPlay()
            player?.play()
            
            if let player = player {
                       
                       musicDuration = player.duration
                       print("Продолжительность трека: \(musicDuration)")
                       
                       
                       startMusicTimer()
                   }
            
        } catch let error {
            print("Ошибка при создании плеера: \(error.localizedDescription)")
        }
    }
    
    
    
    
    
    // starting music
    func startMusicTimer() {
        
        timer?.invalidate()

        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if let player = self.player {
                
               

                
                self.musicCurrentTime = player.currentTime
                
                while self.musicCurrentTime == self.musicDuration{
                    self.nextSound()
                }

                if self.musicCurrentTime == self.musicDuration {
                    
                    print("Трек завершен")
                }
            }
        }
        print("Таймер запущен")
    }


    

   
    
    
    //format time
    func formatTime(_ time: TimeInterval) -> String {
            let minutes = Int(time) / 60
            let seconds = Int(time) % 60
            return String(format: "%02d:%02d", minutes, seconds)
        }
    
    
    
    
    
    

  
    
    
    //update duration
    func updateTimeAndDuration() {
        if let player = player {
            musicCurrentTime = player.currentTime
            musicDuration = player.duration
        }
    }

    
    
    
    
    //stop playing
    func stopSound() {
        player?.pause()
        print("stopped")
//        stopUpdatingNowPlayingInfo() 
        self.isPlaying = false
    }
    
    
    
    
    
    
    //play current track
    func playCurrentTrack() {
        if let player = player, !player.isPlaying {
//            configureAudioSession()
               player.play()
//            startUpdatingNowPlayingInfo()
                startMusicTimer()
            self.isPlaying = true
//            setupRemoteCommandCenter()
            
            
           } else {
               
               let soundName = soundFiles.songs[currentTrackIndex].name
               playSound(named: soundName)
           }
    }
    
    
    
    //return song name
    func songName()->String{
        return soundFiles.songs[currentTrackIndex].name
    }
    
    
    //forwardsoundd
    func nextSound(){
        if currentTrackIndex == soundFiles.songs.count-1 {
            currentTrackIndex = 0
        }else{
            
            currentTrackIndex = currentTrackIndex + 1
        }
            
        playCurrentTrack()
    }
    
    
    
    
    //backwardSound
    func backSound(){
        if currentTrackIndex == 0 {
            currentTrackIndex = soundFiles.songs.count-1
            playCurrentTrack()
        }else{
            currentTrackIndex = (currentTrackIndex - 1) % soundFiles.songs.count
            playCurrentTrack()
        }
        
    }
    
    

//    func configureAudioSession() {
//        do {
//            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
//            try AVAudioSession.sharedInstance().setActive(true)
//        } catch {
//            print("Ошибка активации AVAudioSession: \(error)")
//        }
//    }
//
//    
//    
// 
//    
//    
//    
//    
//    func setupNowPlayingInfo(with title: String, artist: String) {
//        let nowPlayingInfoCenter = MPNowPlayingInfoCenter.default()
//        var nowPlayingInfo = [String: Any]()
//        nowPlayingInfo[MPMediaItemPropertyTitle] = title
//        nowPlayingInfo[MPMediaItemPropertyArtist] = artist
//        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = self.musicCurrentTime
//        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = self.musicDuration
//        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = 1.0
//        nowPlayingInfoCenter.nowPlayingInfo = nowPlayingInfo
//    }
//    
//    func setupRemoteCommandCenter() {
//        let commandCenter = MPRemoteCommandCenter.shared()
//        
//        commandCenter.playCommand.addTarget { event in
//            self.playCurrentTrack()
//            return .success
//        }
//        
//        commandCenter.pauseCommand.addTarget { event in
//            self.stopSound()
//            return .success
//        }
//        
//        commandCenter.togglePlayPauseCommand.addTarget { event in
//            if self.isPlaying {
//                self.stopSound()
//            } else {
//                self.playCurrentTrack()
//            }
//            return .success
//        }
//    }
//    
//    
//   
//
//    func startUpdatingNowPlayingInfo() {
//        timer?.invalidate()
//        
//        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
//            guard let self = self else { return }
//            self.updateNowPlayingElapsedTime()
//        }
//    }
//
//    func updateNowPlayingElapsedTime() {
//        let nowPlayingInfoCenter = MPNowPlayingInfoCenter.default()
//
//        if var nowPlayingInfo = nowPlayingInfoCenter.nowPlayingInfo {
//            nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = self.musicCurrentTime
//            nowPlayingInfoCenter.nowPlayingInfo = nowPlayingInfo
//        }
//    }
//
//    func stopUpdatingNowPlayingInfo() {
//        timer?.invalidate()
//        timer = nil
//    }
//
//    
//    
//    
//    
    
    

}

//volume slider
struct VolumeSliderView: UIViewRepresentable {
    func makeUIView(context: Context) -> MPVolumeView {
        let volumeView = MPVolumeView()
        volumeView.showsVolumeSlider = true
        volumeView.tintColor = .white
        return volumeView
    }
    
    func updateUIView(_ uiView: MPVolumeView, context: Context) {
        
    }
}



//airPlay
struct RouteButtonView: UIViewRepresentable {
    func makeUIView(context: Context) -> AVRoutePickerView {
        let routePickerView = AVRoutePickerView()
        routePickerView.tintColor = .red
        return routePickerView
    }
    
    func updateUIView(_ uiView: AVRoutePickerView, context: Context) {
        
    }
}




