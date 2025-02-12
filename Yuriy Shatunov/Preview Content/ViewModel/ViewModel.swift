//
//  ViewModel.swift
//  My Player
//
//  Created by Haidarov N on 26/09/24.
//

import Foundation
import SwiftUI
import AVFoundation



class ViewModel: ObservableObject {
    @Published var songs: [SongModel] = [
        SongModel(
            name: "Седая Ночь"
        ),
        SongModel(
            name: "Детство"
        ),
        SongModel(
            name: "Лето"
          
        ),
        SongModel(
            name: "От Белых Роз"
          
        ),
        SongModel(
            name: "Письмо"
          
        ),
        SongModel(
            name: "С Днём Рождения"
          
        ),
        SongModel(
            name: "А Ты Возьми и Позвони"
          
        ),
        SongModel(
            name: "Белые Розы"
          
        ),
        SongModel(
            name: "Забудь"
          
        ),
        SongModel(
            name: "Спасибо Тебе"
          
        ),
    ]
    
}
