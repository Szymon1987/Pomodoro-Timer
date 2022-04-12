//
//  TimerModel.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 18/03/2022.
//

import UIKit

enum TimerState {
    case pomodoro
    case shortBreak
    case longBreak
}



struct Model {
    var color: UIColor
    var font: UIFont
    var seconds: Int
}
