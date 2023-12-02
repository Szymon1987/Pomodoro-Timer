//
//  CountdownTimer.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 13/04/2022.
//

import Foundation

// implementation deatails below, fix it
protocol CountdownTimerDelegate: AnyObject {
    
    // updates the delegate's view property every second
    func timerTick(_ currentTime: Int)
    func timerFinished()
    
}

final class CountdownTimer {

    private var isCounting: Bool = false
    private var startTime: Date?
    private var stopTime: Date?
    private var scheduledTimer: Timer!
    private var totalSeconds: Int = 0
    weak var delegate: CountdownTimerDelegate?
    
    init(duration: Int) {
        self.totalSeconds = duration
    }
    
    func startStopTimer() {
        if isCounting {
            setStopTime(date: Date())
            stopTimer()
//            delegate?.pauseAnimation(self)
        } else {
            if let stop = stopTime {
                let restartTime = calculateRestartTime(start: startTime!, stop: stop)
                setStopTime(date: nil)
                setStartTime(date: restartTime)
//                delegate?.resumeAnimation(self)

            } else {
//                delegate?.startAnimation(self, totalSeconds)
                setStartTime(date: Date())
            }
            startTimer()
        }
    }
    
    private func calculateRestartTime(start: Date, stop: Date) -> Date {
        let difference = start.timeIntervalSince(stop)
        return Date().addingTimeInterval(difference)
    }
    
    public func startTimer() {
        scheduledTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(refreshValue), userInfo: nil, repeats: true)
        setTimerCounting(true)
    }
    
    @objc private func refreshValue() {
        if let start = startTime {
            let elapsedTime = Date().timeIntervalSince(start)
            let displayedTime = totalSeconds - Int(elapsedTime)
            
            if displayedTime > 0 {
                delegate?.timerTick(displayedTime)
            } else {
                stopTimer()
                setStartTime(date: Date())
                startTimer()
                countdownFinished()
            }
        }
    }
    
    private func countdownFinished() {
        
        setStartTime(date: nil)
        setStopTime(date: nil)
        stopTimer()
        delegate?.timerFinished()
    }
    
    public func stopTimer() {
        if scheduledTimer != nil {
            scheduledTimer.invalidate()
        }
        setTimerCounting(false)
    }
    
    public func setStartTime(date: Date?) {
        startTime = date
    }
    
    public func setStopTime(date: Date?) {
        stopTime = date
    }
    private func setTimerCounting(_ val: Bool) {
        isCounting = val
    }

    public func setDuration(duration: Int) {
        totalSeconds = duration
    }
}
