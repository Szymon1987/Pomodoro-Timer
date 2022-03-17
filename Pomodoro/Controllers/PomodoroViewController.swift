//
//  ViewController.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 15/10/2021.
//
import UIKit

class PomodoroViewController: UIViewController {
    
    var pomodoroTimerView = PomodoroTimerView()
    
    override func loadView() {
        view = pomodoroTimerView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        pomodoroTimerView.totalSeconds = pomodoroTimerView.pomodoroSeconds
    }
}


