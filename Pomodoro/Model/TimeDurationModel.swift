//
//  TimeDurationModel.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 27/04/2022.
//

import Foundation

struct TimeDurationModel {
    static let defaultPomodoroDuration:   Int = 6
    static let defaultShortBreakDuration: Int = 2
    static let defaultLongBreakDuration:  Int = 3
    
    var pomodoroSeconds: Int
    var shortBreakSeconds: Int
    var longBreakSeconds: Int
    
    internal init(pomodoroSeconds: Int = defaultPomodoroDuration,
                  shortBreakSeconds: Int = defaultShortBreakDuration,
                  longBreakSeconds: Int = defaultLongBreakDuration) {
        self.pomodoroSeconds = pomodoroSeconds
        self.shortBreakSeconds = shortBreakSeconds
        self.longBreakSeconds = longBreakSeconds
    }
}
