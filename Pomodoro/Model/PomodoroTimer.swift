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

    var timerModel = TimerModel() {
        didSet {
            print("set")
        }
    }
    var currentState: Int = 0

    mutating func switchState() -> Int? {
        currentState += 1
        if currentState < timerStates.count {
            switch timerStates[currentState] {
            case .pomodoro:
                return timerModel.pomodoroSeconds
            case .shortBreak:
                return timerModel.shortBreakSeconds
            case .longBreak:
                return timerModel.longBreakSeconds
            }
        } else {
            return nil
        }
    }
}
