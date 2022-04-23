//
//  TimerEngine.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 20/04/2022.
//

import UIKit

class TimerEngine {
    
    weak var mainView: MainView?
    weak var clockView: ClockView?
    
    var timerModel = TimerModel() {
        didSet {
            print("timer model set")
            clockView?.circleShapeLayer.backgroundColor = UIColor.pomodoroBlue.cgColor
            mainView?.titleLabel.backgroundColor = .red
        }
    }
    
    var timer = CountdownTimer() {
        didSet {
            
        }
    }
    
    var appearanceModel = AppearanceModel()
    
//
//    // MARK: - Helpers
//
//    func setTimeLabel(_ val: Int) -> String {
//        let time = SecondsToHoursMinutesSeconds(val)
//        let timeString = makeTimeString(min: time.1, sec: time.2)
//            return timeString
//    }
//
//    private func SecondsToHoursMinutesSeconds(_ ms: Int) -> (Int, Int, Int) {
//        let hour = ms / 3600
//        let min = (ms % 3600) / 60
//        let sec = (ms % 3600) % 60
//        return (hour, min, sec)
//    }
//
//    private func makeTimeString(min: Int, sec: Int) -> String {
//        var timeString = ""
//        timeString += String(format: "%02d", min)
//        timeString += ":"
//        timeString += String(format: "%02d", sec)
//        return timeString
//    }
}

