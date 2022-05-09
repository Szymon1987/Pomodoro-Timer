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
   
    var currentState: Int = 0

    var timeDurationModel = TimeDurationModel() {
        didSet {
            print("set")
        }
    }
    
    mutating func switchState() -> Int? {
        currentState += 1
        if currentState < timerStates.count {
            switch timerStates[currentState] {
            case .pomodoro:
                return timeDurationModel.pomodoroSeconds
            case .shortBreak:
                return timeDurationModel.shortBreakSeconds
            case .longBreak:
                return timeDurationModel.longBreakSeconds
            }
        } else {
            return nil
        }
    }
}
