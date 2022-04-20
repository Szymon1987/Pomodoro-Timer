//
//  CountdownTimer.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 13/04/2022.
//

import Foundation

protocol CountdownTimerDelegate: AnyObject {
    func timerTick(_ countdownTimerDelegate: CountdownTimer, currentTime: Int)
    func changeState(_ countdownTimerDelegate: CountdownTimer, state: Bool)
    func resetLabel(_ countdownTimerDelegate: CountdownTimer)
    func startAnimation(_ countdownTimerDelegate: CountdownTimer, _ duration: Int)
    func pauseAnimation(_ countdownTimerDelegate: CountdownTimer)
    func resumeAnimation(_ countdownTimerDelegate: CountdownTimer)
}

class CountdownTimer {
    
    var pomodoroTimer = PomodoroTimer()
    weak var delegate: CountdownTimerDelegate?
    var timerCounting: Bool = false
    var startTime: Date?
    var stopTime: Date?
    var scheduledTimer: Timer!
    var totalSeconds: Int
    
    init() {
        totalSeconds = pomodoroTimer.pomodoroSeconds
    }
    
    
    func startStopTimer() {
        if timerCounting {
            setStopTime(date: Date())
            stopTimer()
            delegate?.pauseAnimation(self)
        } else {
            if let stop = stopTime {
                let restartTime = calculateRestartTime(start: startTime!, stop: stop)
                setStopTime(date: nil)
                setStartTime(date: restartTime)
                delegate?.resumeAnimation(self)

            } else {
                delegate?.startAnimation(self, totalSeconds)
                setStartTime(date: Date())
            }
            startTimer()
        }
    }
    
    private func calculateRestartTime(start: Date, stop: Date) -> Date {
        let difference = start.timeIntervalSince(stop)
        return Date().addingTimeInterval(difference)
    }
    
    private func startTimer() {
        scheduledTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(refreshValue), userInfo: nil, repeats: true)
        setTimerCounting(true)
        delegate?.changeState(self, state: false)
    }
    
    @objc private func refreshValue() {
        if let start = startTime {
            let elapsedTime = Date().timeIntervalSince(start)
            let displayedTime = totalSeconds - Int(elapsedTime)
            
            if displayedTime > 0 {
                delegate?.timerTick(self, currentTime: displayedTime)
            } else {
                stopTimer()
                if let timerState = pomodoroTimer.switchState() {
                    totalSeconds = timerState
                    setStartTime(date: Date())
                    startTimer()
                    delegate?.startAnimation(self, totalSeconds)
                } else {
                    resetTimer()
                }
            }
        }
    }
    
    
    private func resetTimer() {
        
        delegate?.resetLabel(self)
        totalSeconds = pomodoroTimer.pomodoroSeconds
        pomodoroTimer.currentState = 0
        
        setStartTime(date: nil)
        setStopTime(date: nil)
        stopTimer()
    }
    
    private func stopTimer() {
        if scheduledTimer != nil {
            scheduledTimer.invalidate()
        }
        setTimerCounting(false)
        delegate?.changeState(self, state: true)
    }
    
    private func setStartTime(date: Date?) {
        startTime = date
        //        userDefaults.set(startTime, forKey: START_TIME_KEY)
    }
    
    private func setStopTime(date: Date?) {
        stopTime = date
        //        userDefaults.set(stopTime, forKey: STOP_TIME_KEY)
    }
    private func setTimerCounting(_ val: Bool) {
        timerCounting = val
        //        userDefaults.set(timerCounting, forKey: COUNTING_KEY)
    }
}
