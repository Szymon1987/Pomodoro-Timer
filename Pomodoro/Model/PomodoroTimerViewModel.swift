//
//  TimerEngine.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 20/04/2022.
//

import UIKit

final class PomodoroTimerViewModel {

    private let timeDurationModel = TimeDurationModel()
    private let pomodoroTimer: PomodoroTimer
    private let timer: CountdownTimer
    
    init() {
        timer = CountdownTimer(duration: timeDurationModel.pomodoroSeconds)
        pomodoroTimer = PomodoroTimer(timeDurationModel: timeDurationModel, timer: timer)
    }

    func startStopButtonTapped() {
        timer.startStopTimer()
    }
    
    func setTimerDelegate(_ delegate: PomodoroTimerDelegate) {
        pomodoroTimer.delegate = delegate

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

