//
//  SettingsModel.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 09/03/2022.
//

import UIKit

struct PomodoroModel {
    
    enum TimeIntervals {
        case pomodoro
        case shortBreak
        case longBreak
    }
    
    let intervals: [TimeIntervals] = [.pomodoro, .shortBreak, .pomodoro, .longBreak]

    var currentInterval: Int = 1
    var totalSeconds: Int = 3
    
    var pomodoroSeconds: Int = 3
    var shortBreakSeconds: Int = 1
    var longBreakSeconds: Int = 2
    var colorTheme: UIColor = ColorManager.pomodoroOrange
    var fontTheme: String = "MalayalamSangamMN"
}
