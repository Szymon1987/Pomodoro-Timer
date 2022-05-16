//
//  PomodoroTimer.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 13/04/2022.
//

import Foundation

struct PomodoroTimer {
    
    enum TimerState {
        case pomodoro
        case shortBreak
        case longBreak
    }
    
    private let timerStates: [TimerState] = [.pomodoro, .shortBreak, .pomodoro, .longBreak]
   
    var currentState: Int = 0

//    var timeDurationModel = TimeDurationModel() {
//        didSet {
//            print("set")
//        }
//    }
    
    var timeDurationModel: TimeDurationModel
    
    init(timeDurationModel: TimeDurationModel) {
        self.timeDurationModel = timeDurationModel
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
    
    func switchTwo(closure: (Int) -> Void) {
        
    }
}
