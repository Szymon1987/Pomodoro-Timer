//
//  CountdownTimer.swift
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

protocol CountdownTimerDelegate {
    func updateTime(_ countdownTimerDelegate: CountdownTimer, time: String)
}

class CountdownTimer {
    
    var delegate: CountdownTimerDelegate?
    
    private let timerStates: [TimerState] = [.pomodoro, .shortBreak, .pomodoro, .longBreak]
    
    var totalSeconds: Int = 6
    var pomodoroSeconds: Int = 6
    var shortBreakSeconds: Int = 2
    var longBreakSeconds: Int = 4
    
    var timerCounting: Bool = false
    var startTime: Date?
    var stopTime: Date?
    var scheduledTimer: Timer!
    var currentState: Int = 1
    
    
    func startStopTimer() {
        if timerCounting {
            setStopTime(date: Date())
            stopTimer()
//            pauseAnimation()
        } else {
            if let stop = stopTime {
                let restartTime = calculateRestartTime(start: startTime!, stop: stop)
                setStopTime(date: nil)
                setStartTime(date: restartTime)
//                resumeAnimation()
            } else {
                setStartTime(date: Date())
//                startAnimation()
                // I don't understand why the animation not always work without resume function here
//                resumeAnimation()
            }
            startTimer()
        }
    }
        func calculateRestartTime(start: Date, stop: Date) -> Date {
            let difference = start.timeIntervalSince(stop)
            return Date().addingTimeInterval(difference)
        }
    
        func startTimer() {
            scheduledTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(refreshValue), userInfo: nil, repeats: true)
            setTimerCounting(true)
//            startStopLabel.text = pause
        }
    
        @objc func refreshValue() {
            if let start = startTime {
                let elapsedTime = Date().timeIntervalSince(start)
                let displayedTime = totalSeconds - Int(elapsedTime)
    
                if displayedTime > 0 {
                    let updatedTime = setTimeLabel(displayedTime)
                    delegate?.updateTime(self, time: updatedTime)
    
                } else {
                stopTimer()
                switchInterval()
                }
            }
        }
        func setTimeLabel(_ val: Int) -> String {
            let time = SecondsToHoursMinutesSeconds(val)
            let timeString = makeTimeString(min: time.1, sec: time.2)
//            timerLabel.text = timeString
            return timeString
        }
    
        func SecondsToHoursMinutesSeconds(_ ms: Int) -> (Int, Int, Int) {
            let hour = ms / 3600
            let min = (ms % 3600) / 60
            let sec = (ms % 3600) % 60
            return (hour, min, sec)
        }
    
        func makeTimeString(min: Int, sec: Int) -> String {
            var timeString = ""
            timeString += String(format: "%02d", min)
            timeString += ":"
            timeString += String(format: "%02d", sec)
            return timeString
        }
    
        func stopTimer() {
            if scheduledTimer != nil {
                scheduledTimer.invalidate()
    
            }
            setTimerCounting(false)
//            startStopLabel.text = start
        }
    
        func setStartTime(date: Date?) {
            startTime = date
    //        userDefaults.set(startTime, forKey: START_TIME_KEY)
        }
    
        func setStopTime(date: Date?) {
            stopTime = date
    //        userDefaults.set(stopTime, forKey: STOP_TIME_KEY)
        }
        func setTimerCounting(_ val: Bool) {
            timerCounting = val
    //        userDefaults.set(timerCounting, forKey: COUNTING_KEY)
        }
    
        func switchInterval() {
            if currentState < timerStates.count {
                switch timerStates[currentState] {
                case .pomodoro:
                    totalSeconds = pomodoroSeconds
//                    pomodoroLabel.backgroundColor = pickedColor
//                    pomodoroLabel.textColor = UIColor.darkPurple
//                    shortBreakLabel.backgroundColor = .clear
//                    shortBreakLabel.textColor = UIColor.lightTextColor
//                    longBreakLabel.backgroundColor = .clear
//                    longBreakLabel.textColor = UIColor.lightTextColor
                case .shortBreak:
                    totalSeconds = shortBreakSeconds
//                    shortBreakLabel.backgroundColor = pickedColor
//                    shortBreakLabel.textColor = UIColor.darkPurple
//                    pomodoroLabel.backgroundColor = .clear
//                    pomodoroLabel.textColor = UIColor.lightTextColor
//                    longBreakLabel.backgroundColor = .clear
//                    longBreakLabel.textColor = UIColor.lightTextColor
                case .longBreak:
                    totalSeconds = longBreakSeconds
//                    longBreakLabel.backgroundColor = pickedColor
//                    longBreakLabel.textColor = UIColor.darkPurple
//                    pomodoroLabel.backgroundColor = .clear
//                    pomodoroLabel.textColor = UIColor.lightTextColor
//                    shortBreakLabel.backgroundColor = .clear
//                    shortBreakLabel.textColor = UIColor.lightTextColor
                }
                setStartTime(date: Date())
                startTimer()
                currentState += 1
//                startAnimation()
            } else {
                resetTimer()
            }
        }
    
        func resetTimer() {
//            shapeLayer.removeAllAnimations()
//            shapeLayer.removeAnimation(forKey: "animation")
            currentState = 1
            totalSeconds = 0
            totalSeconds = pomodoroSeconds
            setStartTime(date: nil)
            setStopTime(date: nil)
            stopTimer()
            setTimeLabel(pomodoroSeconds)
            /// We are back in the pomodoroTheme Colors
//            pomodoroLabel.backgroundColor = pickedColor
//            pomodoroLabel.textColor = UIColor.darkPurple
//            shortBreakLabel.backgroundColor = .clear
//            shortBreakLabel.textColor = UIColor.lightTextColor
//            longBreakLabel.backgroundColor = .clear
//            longBreakLabel.textColor = UIColor.lightTextColor
    
        }
}
