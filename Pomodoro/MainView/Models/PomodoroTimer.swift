//
//  PomodoroTimer.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 13/04/2022.
//

import Foundation

protocol PomodoroTimerDelegate {
    func timerTick(_ currentTime: Int)
    func reset()
}

final class PomodoroTimer {
   
   private enum TimerState {
        case pomodoro
        case shortBreak
        case longBreak
    }
    
    private let timerMode: [TimerState] = [.pomodoro, .shortBreak, .pomodoro, .longBreak]
   
    private var currentMode: Int = 1
    var delegate: PomodoroTimerDelegate?
    
    private let timeDurationModel: TimeDurationModel
    private let timer: CountdownTimer
    
    init (timeDurationModel: TimeDurationModel, timer: CountdownTimer) {
        self.timeDurationModel = timeDurationModel
        self.timer = timer
        self.timer.delegate = self
    }

    func switchTimerMode() {
        
        if currentMode < timerMode.count {
            switch timerMode[currentMode] {
            case .pomodoro:
                timer.setDuration(duration: timeDurationModel.pomodoroSeconds)
            case .shortBreak:
                timer.setDuration(duration: timeDurationModel.shortBreakSeconds)
            case .longBreak:
                timer.setDuration(duration: timeDurationModel.longBreakSeconds)
            }
            
            timer.setStartTime(date: Date())
            timer.startTimer()
            currentMode += 1
        } else {
            timer.stopTimer()
            timer.setStopTime(date: nil)
            currentMode = 1
            timer.setDuration(duration: timeDurationModel.pomodoroSeconds)
            delegate?.reset()
        }
    }
}

extension PomodoroTimer: CountdownTimerDelegate {
   
    func timerTick(_ currentTime: Int) {
        self.delegate?.timerTick(currentTime)
    }
    
    func timerFinished() {
        switchTimerMode()
        
        
        // pass reset to the delegate later
    }
}
