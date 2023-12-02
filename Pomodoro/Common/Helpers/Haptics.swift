//
//  Haptics.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 02/03/2022.
//

import UIKit

struct Haptics {
    static func light() {
        triggerHapticMethodWith(style: .light)
    }
    
    static func heavy() {
        triggerHapticMethodWith(style: .heavy)
    }
    
    static func triggerHapticMethodWith(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        UIImpactFeedbackGenerator(style: style).impactOccurred()
    }
}
