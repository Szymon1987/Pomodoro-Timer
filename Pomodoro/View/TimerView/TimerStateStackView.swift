//
//  TimerStateView.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 18/03/2022.
//

import UIKit

class TimerStateStackView: UIStackView {
    
    let pomodoroLabel: ReusableLabel
    let shortBreakLabel: ReusableLabel
    let longBreakLabel: ReusableLabel
    
    
    init() {
        pomodoroLabel = ReusableLabel(text: "pomodoro", fontSize: 18)
        shortBreakLabel = ReusableLabel(text: "short break", fontSize: 18)
        longBreakLabel = ReusableLabel(text: "long break", fontSize: 18)
        super.init(frame: .zero)
        setupTimerStateStackView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    private func setupTimerStateStackView() {
        backgroundColor = UIColor.darkPurple
        layer.masksToBounds = true
        addArrangedSubview(pomodoroLabel)
        addArrangedSubview(shortBreakLabel)
        addArrangedSubview(longBreakLabel)
        translatesAutoresizingMaskIntoConstraints = false
        
        distribution = .fillEqually
        spacing = 5
        
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = UIEdgeInsets(top: 7, left: 10, bottom: 7, right: 10)
        pomodoroLabel.backgroundColor = .green
        shortBreakLabel.backgroundColor = .green
        longBreakLabel.backgroundColor = .green
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        [pomodoroLabel, shortBreakLabel, longBreakLabel].forEach{$0.layer.cornerRadius = pomodoroLabel.frame.height / 2}
        print(pomodoroLabel.frame.height)
        self.layer.cornerRadius = self.frame.height / 2
    }
}
