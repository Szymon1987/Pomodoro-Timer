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
    
    var timeDurations = TimesDurationModel()
    
    private let timerStates: [TimerState] = [.pomodoro, .shortBreak, .pomodoro, .longBreak]
  
    
    
//    var pomodoroSeconds: Int = 6
//    var shortBreakSeconds: Int = 2
//    var longBreakSeconds: Int = 4
    
    var currentState: Int = 0

    mutating func switchState() -> Int? {
        currentState += 1
        if currentState < timerStates.count {
            switch timerStates[currentState] {
            case .pomodoro:
//                return pomodoroSeconds
                return timeDurations.pomodoroSeconds
            case .shortBreak:
//                return shortBreakSeconds
                return timeDurations.shortBreakSeconds
            case .longBreak:
//                return longBreakSeconds
                return timeDurations.longBreakSecons
            }
        } else {
            return nil
        }
    }
}
