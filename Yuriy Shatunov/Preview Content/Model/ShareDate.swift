//
//  ShareDate.swift
//  Yuriy Shatunov
//
//  Created by Haidarov N on 29/10/24.
//

import SwiftUI
import Combine

class SharedData: ObservableObject {
    @Published var isToggled: Bool = false
}
