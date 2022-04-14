//
//  ClockView.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 21/03/2022.
//

import UIKit

class ClockView: UIView {
    
    let clockLabel: ReusableLabel
    let startStopButton: ReusableButton
//    var timer: PomodoroTimer
    var timer = CountdownTimer()
    
    init() {
        clockLabel = ReusableLabel(text: "00:06", fontSize: 54, textColor: .white)
        
        // is it ok to use "Constants.start" during initialization below?
        startStopButton = ReusableButton(title: Constants.start, fontType: .normalFont(size: 22), textColor: .white)
//        timer = PomodoroTimer()
        super.init(frame: .zero)
        timer.delegate = self
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.darkPurple
        setupViews()
        configureStartStopButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // this code is duplicated as well
    private func configureStartStopButton() {
        startStopButton.addTarget(self, action: #selector(startStopButtonTapped), for: .touchUpInside)
    }
    
    @objc private func startStopButtonTapped() {
        timer.startStopTimer()
    }
    
    // MARK: - Helpers
    
    private func setTimeLabel(_ val: Int) {
        let time = SecondsToHoursMinutesSeconds(val)
        let timeString = makeTimeString(min: time.1, sec: time.2)
            clockLabel.text = timeString
    }

    private func SecondsToHoursMinutesSeconds(_ ms: Int) -> (Int, Int, Int) {
        let hour = ms / 3600
        let min = (ms % 3600) / 60
        let sec = (ms % 3600) % 60
        return (hour, min, sec)
    }

    private func makeTimeString(min: Int, sec: Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", min)
        timeString += ":"
        timeString += String(format: "%02d", sec)
        return timeString
    }
    
    //MARK: - View Setup
    
    private func setupViews() {
        addSubview(clockLabel)
        clockLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10).isActive = true
        clockLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        addSubview(startStopButton)
        startStopButton.topAnchor.constraint(equalTo: clockLabel.bottomAnchor, constant: 17).isActive = true
        startStopButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        startStopButton.leadingAnchor.constraint(equalTo: clockLabel.leadingAnchor).isActive = true
        startStopButton.trailingAnchor.constraint(equalTo: clockLabel.trailingAnchor).isActive = true
        
        startStopButton.titleLabel?.setTextSpacingBy(value: 10)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.frame.height / 2
    }
}

//extension ClockView: PomodoroTimerDelegate {
//
//    func timerTick(_ countdownTimerDelegate: PomodoroTimer, currentTime: Int) {
//        DispatchQueue.main.async {
//            self.setTimeLabel(currentTime)
//        }
//    }
//
//
//}

extension ClockView: CountdownTimerDelegate {
    
    func timerTick(_ countdownTimerDelegate: CountdownTimer, currentTime: Int) {
        DispatchQueue.main.async {
            self.setTimeLabel(currentTime)
        }
    }
    
    func changeState(_ countdownTimerDelegate: CountdownTimer, state: Bool) {
        DispatchQueue.main.async {
            if state {
                self.startStopButton.setTitle(Constants.start, for: .normal)
            } else {
                self.startStopButton.setTitle(Constants.stop, for: .normal)
            }
        }
    }
    func resetLabel(_ countdownTimerDelegate: CountdownTimer) {
        DispatchQueue.main.async {
            self.clockLabel.text = "00:00"
        }
    }
}
