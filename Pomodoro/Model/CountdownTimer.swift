//
//  CountdownTimer.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 13/04/2022.
//

import Foundation

protocol CountdownTimerDelegate {
    func timerTick(_ countdownTimerDelegate: CountdownTimer, currentTime: Int)
    func changeState(_ countdownTimerDelegate: CountdownTimer, state: Bool)
    func resetLabel(_ countdownTimerDelegate: CountdownTimer)
}

class CountdownTimer {
    
    var pomodoroTimer = PomodoroTimer()
    var delegate: CountdownTimerDelegate?
    var timerCounting: Bool = false
    var startTime: Date?
    var stopTime: Date?
    var scheduledTimer: Timer!
    var totalSeconds: Int = 6
    
    
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
                } else {
                    resetTimer()
                }
            }
        }
    }
    
    
    private func resetTimer() {
        
        totalSeconds = pomodoroTimer.pomodoroSeconds
        setStartTime(date: nil)
        setStopTime(date: nil)
        stopTimer()
        pomodoroTimer.currentState = 0
        delegate?.resetLabel(self)
        
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
