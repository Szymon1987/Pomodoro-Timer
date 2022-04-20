//
//  Model.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 12/04/2022.
//

import UIKit


// should he model look like below?

struct SettingsModel {
    var color: UIColor = .pomodoroOrange
    var font: UIFont = .normalFont(size: 16)
    
    var pomodoroSeconds: Int = 4
    var shortBreakSeconds: Int = 2
    var longBreakSecons: Int = 3
}



// Or like that?

//struct ColorFont {
//    var color: UIColor = .pomodoroOrange
//    var font: UIFont = .normalFont(size: 16)
//}
//
//struct TimeStates {
//    var pomodoroSeconds: Int = 4
//    var shortBreakSeconds: Int = 2
//    var longBreakSecons: Int = 3
//}

