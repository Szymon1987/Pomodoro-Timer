//
//  Model.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 12/04/2022.
//

import Foundation


enum TimerState {
    case pomodoro
    case shortBreak
    case longBreak
}

struct Model {
    let color: String
    let font: String
    let seconds: Int
}
