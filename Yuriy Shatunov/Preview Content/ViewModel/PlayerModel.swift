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


class AudioPlayer: NSObject, ObservableObject, AVAudioPlayerDelegate {
    var player: AVAudioPlayer?
    @ObservedObject var soundFiles = ViewModel()
    var currentTrackIndex = 0
    @State var isPlaying: Bool = false
    @Published var musicCurrentTime: TimeInterval = 0.0
    @Published var musicDuration: TimeInterval = 0.0
    @State var timer: Timer?
    @Published var currentSong: String = ""
    
    
    func playSound(named soundName: String) {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
            try AVAudioSession.sharedInstance().setActive(true)
            
            var nowPlayingInfo = [String: Any]()
            nowPlayingInfo[MPMediaItemPropertyTitle] = songName()
            nowPlayingInfo[MPMediaItemPropertyArtist] = "Юрий Шатунов"
            MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
            UIApplication.shared.beginReceivingRemoteControlEvents()
            setupRemoteTransportControls()
        } catch {
            print("Ошибка настройки аудиосессии: \(error.localizedDescription)")
        }
        
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else {
            print("Файл не найден: \(soundName).mp3")
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.delegate = self // Устанавливаем делегата
            player?.prepareToPlay()
            player?.play()
            
            if let player = player {
                musicDuration = player.duration
                startMusicTimer()
            }
        } catch let error {
            print("Ошибка при создании плеера: \(error.localizedDescription)")
        }
    }
    
    
    
    
    
    
    private func setupRemoteTransportControls() {
        let commandCenter = MPRemoteCommandCenter.shared()
        
        commandCenter.nextTrackCommand.addTarget { [unowned self] event in
            self.nextSound()
            if self.player?.rate == 0.0 {
                return .success
            }
            return .commandFailed
        }
        
        commandCenter.previousTrackCommand.addTarget { [unowned self] event in
            self.nextSound()
            if self.player?.rate == 0.0 {
                return .success
            }
            return .commandFailed
        }
  
        commandCenter.playCommand.addTarget { [unowned self] event in
            self.playCurrentTrack()
            return .success
        }
        
        commandCenter.pauseCommand.addTarget { [unowned self] event in
            self.stopSound()
            return .success
        }
    }

    // Start music timer
    func startMusicTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if let player = self.player {
                self.musicCurrentTime = player.currentTime
                if self.musicCurrentTime >= self.musicDuration {
                    self.stopMusicTimer() // Остановить таймер, когда трек завершён
                }
            }
            
        }
        print("Таймер запущен")
    }
    
    // Stop music timer
    func stopMusicTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    // AVAudioPlayerDelegate method
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            stopMusicTimer()
            nextSound()
        }
    }
    
    // Play next track
    func nextSound() {
        if currentTrackIndex == soundFiles.songs.count - 1 {
            currentTrackIndex = 0
        } else {
            currentTrackIndex += 1
        }
        
        let nextTrack = soundFiles.songs[currentTrackIndex].name
        playSound(named: nextTrack)
        self.isPlaying = true
        
    }
    
    // Play current track
    func playCurrentTrack() {
        if let player = player, !player.isPlaying {
            player.play()
            self.isPlaying = true
        } else {
            let soundName = soundFiles.songs[currentTrackIndex].name
            playSound(named: soundName)
        }
        
        self.isPlaying = true
    }
    
    // Stop playing
    func stopSound() {
        player?.pause()
        stopMusicTimer()
        self.isPlaying = false
        
    }
    
    //backwardSound
    func backSound(){
        if currentTrackIndex == 0 {
            currentTrackIndex = soundFiles.songs.count-1
            
        }else{
            currentTrackIndex = (currentTrackIndex - 1) % soundFiles.songs.count
            
        }
        let nextTrack = soundFiles.songs[currentTrackIndex].name
        playSound(named: nextTrack)
        self.isPlaying = true
     
    }
    
    //format time
    func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    //song name
    func songName()->some View{
        Text(soundFiles.songs[currentTrackIndex].name)
    }
    
    func durationMusic(){
        playCurrentTrack()
        stopSound()
    }
}


