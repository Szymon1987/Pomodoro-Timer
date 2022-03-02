//
//  Haptics.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 02/03/2022.
//

import UIKit

struct Haptics {
    static func playLightImpact() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
}
