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
    let timer = CountdownTimer()
    
    init() {
        clockLabel = ReusableLabel(text: "00:06", fontSize: 54, textColor: .white)
        
        // is it ok to use "Constants.start" during initialization below?
        startStopButton = ReusableButton(title: Constants.start, fontType: .normalFont(size: 22), textColor: .white)
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

extension ClockView: CountdownTimerDelegate {
    
    func updateTime(_ countdownTimerDelegate: CountdownTimer, time: String) {
        DispatchQueue.main.async {
            self.clockLabel.text = time
        }
    }
    
    
}
