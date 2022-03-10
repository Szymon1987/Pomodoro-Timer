//
//  TimerModel.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 09/03/2022.
//

import UIKit

struct TimerModel {

    var timerCounting: Bool = false
    var startTime: Date?
    var stopTime: Date?
    var scheduledTimer: Timer!
    
}
