import SwiftUI
import AVFoundation

struct CxontentView: View {
    @State var player: AVAudioPlayer?
    @State var musicCurrentTime: TimeInterval = 0
    @State var musicDuration: TimeInterval = 0
    @State var timer: Timer?

    var body: some View {
        VStack {
            Button(action: {
                playMusic()
            }) {
                Text("Play Music")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            if musicDuration > 0 {
                VStack {
                    Text("Music Duration: \(formatTime(musicDuration))")
                    
                    // Слайдер для отображения и изменения времени воспроизведения
                    Slider(value: Binding(
                        get: {
                            self.musicCurrentTime // Привязка к состоянию
                        },
                        set: { (newValue) in
                            self.musicCurrentTime = newValue // Обновление состояния
                            self.player?.currentTime = newValue // Обновление текущего времени аудиоплеера
                        }
                    ), in: 0...musicDuration)
                    .padding()

                    Text("Current Playback: \(formatTime(musicCurrentTime))")
                        .onAppear {
                            self.startMusicTimer()
                        }
                }
                .padding()
            }
        }
    }

    func playMusic() {
        if let url = Bundle.main.url(forResource: "music5", withExtension: "mp3") {
            do {
                self.player = try AVAudioPlayer(contentsOf: url)
                self.player?.play()

                // Получаем общую длительность трека
                if let player = self.player {
                    self.musicDuration = player.duration
                    self.musicCurrentTime = player.currentTime
                }

            } catch {
                print("Error playing music: \(error.localizedDescription)")
            }
        }
    }

    func startMusicTimer() {
        self.timer?.invalidate() // Остановим предыдущий таймер, если был
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if let player = self.player {
                self.musicCurrentTime = player.currentTime
                if self.musicCurrentTime >= self.musicDuration {
                    self.timer?.invalidate() // Остановить таймер, если музыка закончилась
                }
            }
        }
    }

    func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CxontentView()
    }
}
