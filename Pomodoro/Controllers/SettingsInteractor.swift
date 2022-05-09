//
//  SettingsInteractor.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 28/04/2022.
//

import UIKit

struct SettingsInteractor {
    
    struct AppearanceModel {
        static let defaultColor: UIColor = .pomodoroOrange
        static let defaultFont: UIFont =   .normalFont(size: 16)
        
        var color: UIColor
        var font: UIFont
        
        internal init(color: UIColor = defaultColor, font: UIFont = defaultFont) {
            self.color = color
            self.font = font
        }
    }
}
