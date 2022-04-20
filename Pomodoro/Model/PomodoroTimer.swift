//
//  PomodoroTimer.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 13/04/2022.
//

import Foundation

enum TimerState {
    case pomodoro
    case shortBreak
    case longBreak
}

struct PomodoroTimer {
    
    private let timerStates: [TimerState] = [.pomodoro, .shortBreak, .pomodoro, .longBreak]
  
    
    // should the variable below be initialized from out model?
    // have a look to SettingsModel for the variations
    
    var pomodoroSeconds: Int = 6
    var shortBreakSeconds: Int = 2
    var longBreakSeconds: Int = 4
    
    
    // currentState tracks if we currently counting down pomodoro focus time or maybe break time short or long. These are saved in the timerStates array above
    
    var currentState: Int = 0

    mutating func switchState() -> Int? {
        currentState += 1
        if currentState < timerStates.count {
            switch timerStates[currentState] {
            case .pomodoro:
                return pomodoroSeconds
            case .shortBreak:
                return shortBreakSeconds
            case .longBreak:
                return longBreakSeconds
            }
        } else {
            return nil
        }
    }
}
