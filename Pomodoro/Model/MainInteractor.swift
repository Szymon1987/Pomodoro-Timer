//
//  TimerEngine.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 20/04/2022.
//

import UIKit

struct MainInteractor {

    var timeDurationModel = TimeDurationModel() {
        didSet {
            print("timer model set")
        }
    }
    
    var appearanceModel = AppearanceModel() {
        didSet {
            print("Appearance model set")
            
        }
    }
    private let pomodoroTimer: PomodoroTimer
    public var timer: CountdownTimer
    
    init() {
        pomodoroTimer = PomodoroTimer(timeDurationModel: timeDurationModel)
        timer = CountdownTimer(pomodoroTimer: pomodoroTimer)
    }

    func startStopButtonTapped() {
        timer.startStopTimer()
    }
    
    
    // MARK: - Helpers

    public func setTimeLabel(_ val: Int) -> String {
        let time = SecondsToHoursMinutesSeconds(val)
        let timeString = makeTimeString(min: time.1, sec: time.2)
            return timeString
    }
    
    private func SecondsToHoursMinutesSeconds(_ ms: Int) -> (Int, Int, Int) {
        let hour = ms / 3600
        let min = (ms % 3600) / 60
        let sec = (ms % 3600) % 60
        return (hour, min, sec)
    }

    private func makeTimeString(min: Int, sec: Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", min)
        timeString += ":"
        timeString += String(format: "%02d", sec)
        return timeString
    }
}

