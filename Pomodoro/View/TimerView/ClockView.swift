//
//  ClockView.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 21/03/2022.
//

import UIKit

class ClockView: UIView {
    
    private let clockLabel: ReusableLabel
    private let startStopButton: ReusableButton
    private let mainInteractor: MainInteractor

    public let circleShapeLayer = CAShapeLayer()

    init(mainInteractor: MainInteractor) {
        clockLabel = ReusableLabel(text: "00:06", fontSize: 54, textColor: .white)
        startStopButton = ReusableButton(title: Constants.start, fontType: .normalFont(size: 22), textColor: .white)
        self.mainInteractor = mainInteractor
        super.init(frame: .zero)
        mainInteractor.timer.delegate = self
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.darkPurple
        setupViews()
        setupShapeLayer()
        configureStartStopButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureStartStopButton() {
        startStopButton.addTarget(self, action: #selector(startStopButtonTapped), for: .touchUpInside)
        startStopButton.titleLabel?.setTextSpacingBy(value: 10)
    }
    
    @objc private func startStopButtonTapped() {
        mainInteractor.startStopButtonTapped()
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
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.frame.height / 2
        
        let center = CGPoint(x: layer.bounds.midX, y: layer.bounds.midY)
       
        let radius = (self.frame.height - 35) / 2
        let circularPath = UIBezierPath(arcCenter: .zero, radius: radius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        circleShapeLayer.position = center
        circleShapeLayer.path = circularPath.cgPath
        
        // if startAngle isn't set to 0 there is a bug in animation. CircleShapeLayer is rotated 90 degree
        circleShapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
    }
    
    private func setupShapeLayer() {
        
        circleShapeLayer.strokeColor = UIColor.pomodoroOrange.cgColor
        circleShapeLayer.lineWidth = 10
        circleShapeLayer.lineCap = .round
        circleShapeLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(circleShapeLayer)

    }
}

    //MARK: - CountdownTimerDelegate

extension ClockView: CountdownTimerDelegate {
    
    func timerTick(_ countdownTimerDelegate: CountdownTimer, currentTime: Int) {
        clockLabel.text = mainInteractor.setTimeLabel(currentTime)
    }
    
    func toggleIsRunning(_ countdownTimerDelegate: CountdownTimer, iaRunning: Bool) {
            if iaRunning {
                self.startStopButton.setTitle(Constants.start, for: .normal)
            } else {
                self.startStopButton.setTitle(Constants.stop, for: .normal)
            }
        
        // set the spacing between the titleLabell characters when button is pressed. Should we do it every time when button is pressed or is can we do it more efficiently only once?
        startStopButton.titleLabel?.setTextSpacingBy(value: 10)
    }
    
    func reset(_ countdownTimerDelegate: CountdownTimer) {
            self.clockLabel.text = "00:00"
    }
    
    
    func startAnimation(_ countdownTimerDelegate: CountdownTimer, _ duration: Int) {
        let circleAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circleAnimation.fromValue = 1
        circleAnimation.toValue = 0
        circleAnimation.duration = CFTimeInterval(duration)
        circleAnimation.isRemovedOnCompletion = false
        circleShapeLayer.add(circleAnimation, forKey: "animation")
    }
    func pauseAnimation(_ countdownTimerDelegate: CountdownTimer) {
        let pausedTime: CFTimeInterval = circleShapeLayer.convertTime(CACurrentMediaTime(), from: nil)
        circleShapeLayer.speed = 0.0
        circleShapeLayer.timeOffset = pausedTime
    }
    func resumeAnimation(_ countdownTimerDelegate: CountdownTimer) {
        let pausedTime = circleShapeLayer.timeOffset
        circleShapeLayer.speed = 1.0
        circleShapeLayer.timeOffset = 0.0
        circleShapeLayer.beginTime = 0.0
        circleShapeLayer.strokeEnd = 1.0
        let timeSincePause = circleShapeLayer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        circleShapeLayer.beginTime = timeSincePause
    }
}
