//
//  SharePromptView.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 09/03/2022.
//

import UIKit

class MainView: UIView {
    
    let titleLabel: ReusableLabel
    
    let timerStateStackView = TimerStateStackView()
    
    let timerView = TimerView()
    
//    let settingsButton: ReusableButton
    
    private lazy var settingsButton: ReusableButton = {
        let button = ReusableButton(imageName: "settingsIcon")
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(settingsIconTapped)))
        return button
    }()
    
//    private lazy var settingsView: SettingsView = {
//        let st = SettingsView()
//        st.mainView = self
//        return st
//    }()
    
    
    private lazy var newSettingsView: NewSettingsView = {
        let st = NewSettingsView()
        st.mainView = self
        return st
    }()
    
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        titleLabel = ReusableLabel(text: "pomodoro", fontSize: 24)
//        settingsButton = ReusableButton(imageName: "settingsIcon")
        super.init(frame: frame)
        backgroundColor = .backgroundPurple
        createSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // MARK: - UIActions

    @objc private func settingsIconTapped() {
        Haptics.playLightImpact()
        setupSettingsView()
    }
    
    private let timerStates: [TimerState] = [.pomodoro, .shortBreak, .pomodoro, .longBreak]
    
    var totalSeconds: Int = 6
    var pomodoroSeconds: Int = 6
    var shortBreakSeconds: Int = 2
    var longBreakSeconds: Int = 4
    
    var timerCounting: Bool = false
    var startTime: Date?
    var stopTime: Date?
    var scheduledTimer: Timer!
    var currentState: Int = 1
    
    // change this
    private var pickedColor: UIColor = UIColor.pomodoroOrange
    private var pickedFont: String = "MalayalamSangamMN"

    // MARK: - Constants
    private let start: String = "S T A R T"
    private let pause: String = "P A U S E"
    
    
    // MARK: - GradientLayer Views

    lazy var roundedGradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.colors = [UIColor.darkPurple.cgColor, UIColor.backgroundPurpleLight.cgColor]
        gradient.locations = [0.2, 1]
        return gradient
    }()
    
    let darkPurpleCircleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkPurple
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lightPurpleCircleView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let shadowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.darkPurple
        view.layer.masksToBounds = false
        return view
    }()
    
    
    // MARK: - UIComponents
//
//    private let timerLabel: UILabel = {
//        let label = UILabel()
//        label.text = "00:06"
//        label.textAlignment = .center
//        label.font = UIFont(name: "MalayalamSangamMN-Bold", size: 54)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.textColor = .white
//        return label
//    }()
    
/// need to adjust the font size correctly to fit the smaller screens
//    private lazy var startStopLabel: UILabel = {
//        let label = UILabel()
//        label.text = start
//        label.textAlignment = .center
//        label.font = UIFont(name: "MalayalamSangamMN-Bold", size: 22)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.textColor = .white
//        label.isUserInteractionEnabled = true
////        label.font = UIFont.preferredFont(forTextStyle: .body)
////        label.adjustsFontForContentSizeCategory = true
//        label.numberOfLines = 1
//        label.adjustsFontSizeToFitWidth = true
//        label.minimumScaleFactor = 0.2
//        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(startStopTapped)))
//        return label
//    }()

    
//    lazy var shapeLayer: CAShapeLayer = {
//        let layer = CAShapeLayer()
//        layer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
//        layer.strokeColor = UIColor.pomodoroOrange.cgColor
//        layer.lineWidth = 10
//        layer.fillColor = UIColor.clear.cgColor
//        layer.lineCap = .round
//        layer.strokeEnd = 1
//        return layer
//    }()
//
//
//
//
//    func setupRoundedViews() {
//        darkPurpleCircleView.layer.cornerRadius = darkPurpleCircleView.frame.height / 2
//        roundedGradient.frame = lightPurpleCircleView.bounds
//
//        lightPurpleCircleView.layer.addSublayer(roundedGradient)
//        lightPurpleCircleView.layer.cornerRadius = lightPurpleCircleView.frame.height / 2
//        lightPurpleCircleView.layer.shadowColor = UIColor.black.cgColor
//        lightPurpleCircleView.layer.shadowOffset = CGSize(width: 60, height: 60)
//        lightPurpleCircleView.layer.shadowOpacity = 1
//        lightPurpleCircleView.layer.shadowRadius = 10
//
//        shadowView.layer.cornerRadius = shadowView.frame.height / 2
//        shadowView.layer.shadowColor = UIColor.backgroundPurpleLight.cgColor
//
//        shadowView.layer.rasterizationScale = UIScreen.main.scale
//        shadowView.layer.shadowRadius = 40
//        shadowView.layer.shadowOpacity = 0.5
//        shadowView.layer.shadowOffset = CGSize(width: -25, height: -40)
//    }
//
//
//    func setupTimerView() {
//        let radius = (timerView.frame.height - 60) / 2
//        let circularPath = UIBezierPath(arcCenter: .zero, radius: radius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
//        shapeLayer.path = circularPath.cgPath
//        // had to reposition to the center otherwise there is a bug in the animation when originally setting "startAngle" to -CGFloat.pi / 2
//
//        let center = CGPoint(x: timerView.layer.bounds.midX, y: timerView.layer.bounds.midY)
//        shapeLayer.position = center
//        timerView.layer.addSublayer(shapeLayer)
//
//    }
    
    
    // MARK: - Animation Methods

//    func startAnimation() {
//        let circleAnimation = CABasicAnimation(keyPath: "strokeEnd")
//        circleAnimation.fromValue = 1
//        circleAnimation.toValue = 0
//        circleAnimation.duration = CFTimeInterval(totalSeconds)
//        circleAnimation.isRemovedOnCompletion = false
//        shapeLayer.add(circleAnimation, forKey: "animation")
//    }
//
//    private func pauseAnimation() {
//        let pausedTime: CFTimeInterval = shapeLayer.convertTime(CACurrentMediaTime(), from: nil)
//        shapeLayer.speed = 0.0
//        shapeLayer.timeOffset = pausedTime
//    }
//
//    private func resumeAnimation() {
//        let pausedTime = shapeLayer.timeOffset
//        shapeLayer.speed = 1.0
//        shapeLayer.timeOffset = 0.0
//        shapeLayer.beginTime = 0.0
//        shapeLayer.strokeEnd = 1.0
//        let timeSincePause = shapeLayer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
//        shapeLayer.beginTime = timeSincePause
//    }
 
    
    // MARK: Timer functions

//    func didUpdateUI(with pomodoroMinutes: Int, with shortBreakMinutes: Int, with longBreakMinutes: Int, font: String, color: UIColor) {
//
//        self.resetTimer()
//        self.pomodoroSeconds = pomodoroMinutes * 60
//        self.shortBreakSeconds = shortBreakMinutes * 60
//        self.longBreakSeconds = longBreakMinutes * 60
//        self.pickedFont = font
//        self.pickedColor = color
//
//        DispatchQueue.main.async {
//                self.pomodoroLabel.backgroundColor = color
//                self.shapeLayer.strokeColor = color.cgColor
//            self.titleLabel.font = UIFont(name: font, size: self.titleLabel.font.pointSize)
//                self.pomodoroLabel.font = UIFont(name: self.pickedFont, size: self.pomodoroLabel.font.pointSize)
//                self.shortBreakLabel.font = UIFont(name: self.pickedFont, size: self.shortBreakLabel.font.pointSize)
//                self.longBreakLabel.font = UIFont(name: self.pickedFont, size: self.longBreakLabel.font.pointSize)
//                self.timerLabel.font = UIFont(name: self.pickedFont, size: self.timerLabel.font.pointSize)
//                self.startStopLabel.font = UIFont(name: self.pickedFont, size: self.startStopLabel.font.pointSize)
//                self.resetTimer()
//            print(self.startStopLabel.font.pointSize)
//
//        }
//    }

//    @objc private func startStopTapped() {
//        if timerCounting {
//            setStopTime(date: Date())
//            stopTimer()
//            pauseAnimation()
//        } else {
//            if let stop = stopTime {
//                let restartTime = calculateRestartTime(start: startTime!, stop: stop)
//                setStopTime(date: nil)
//                setStartTime(date: restartTime)
//                resumeAnimation()
//            } else {
//                setStartTime(date: Date())
//                startAnimation()
//                // I don't understand why the animation not always work without resume function here
//                resumeAnimation()
//            }
//            startTimer()
//        }
//    }
//
//    func calculateRestartTime(start: Date, stop: Date) -> Date {
//        let difference = start.timeIntervalSince(stop)
//        return Date().addingTimeInterval(difference)
//    }
//
//    func startTimer() {
//        scheduledTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(refreshValue), userInfo: nil, repeats: true)
//        setTimerCounting(true)
//        startStopLabel.text = pause
//    }
//
//    @objc func refreshValue() {
//        if let start = startTime {
//            let elapsedTime = Date().timeIntervalSince(start)
//            let displayedTime = totalSeconds - Int(elapsedTime)
//
//            if displayedTime > 0 {
//                setTimeLabel(displayedTime)
//
//            } else {
//            stopTimer()
//            switchInterval()
//            }
//        }
//    }
//    func setTimeLabel(_ val: Int) {
//        let time = SecondsToHoursMinutesSeconds(val)
//        let timeString = makeTimeString(min: time.1, sec: time.2)
//        timerLabel.text = timeString
//    }
//
//    func SecondsToHoursMinutesSeconds(_ ms: Int) -> (Int, Int, Int) {
//        let hour = ms / 3600
//        let min = (ms % 3600) / 60
//        let sec = (ms % 3600) % 60
//        return (hour, min, sec)
//    }
//
//    func makeTimeString(min: Int, sec: Int) -> String {
//        var timeString = ""
//        timeString += String(format: "%02d", min)
//        timeString += ":"
//        timeString += String(format: "%02d", sec)
//        return timeString
//    }
//
//    func stopTimer() {
//        if scheduledTimer != nil {
//            scheduledTimer.invalidate()
//
//        }
//        setTimerCounting(false)
//        startStopLabel.text = start
//    }
//
//    func setStartTime(date: Date?) {
//        startTime = date
////        userDefaults.set(startTime, forKey: START_TIME_KEY)
//    }
//
//    func setStopTime(date: Date?) {
//        stopTime = date
////        userDefaults.set(stopTime, forKey: STOP_TIME_KEY)
//    }
//    func setTimerCounting(_ val: Bool) {
//        timerCounting = val
////        userDefaults.set(timerCounting, forKey: COUNTING_KEY)
//    }
//
//    func switchInterval() {
//        if currentState < timerStates.count {
//            switch timerStates[currentState] {
//            case .pomodoro:
//                totalSeconds = pomodoroSeconds
//                pomodoroLabel.backgroundColor = pickedColor
//                pomodoroLabel.textColor = UIColor.darkPurple
//                shortBreakLabel.backgroundColor = .clear
//                shortBreakLabel.textColor = UIColor.lightTextColor
//                longBreakLabel.backgroundColor = .clear
//                longBreakLabel.textColor = UIColor.lightTextColor
//            case .shortBreak:
//                totalSeconds = shortBreakSeconds
//                shortBreakLabel.backgroundColor = pickedColor
//                shortBreakLabel.textColor = UIColor.darkPurple
//                pomodoroLabel.backgroundColor = .clear
//                pomodoroLabel.textColor = UIColor.lightTextColor
//                longBreakLabel.backgroundColor = .clear
//                longBreakLabel.textColor = UIColor.lightTextColor
//            case .longBreak:
//                totalSeconds = longBreakSeconds
//                longBreakLabel.backgroundColor = pickedColor
//                longBreakLabel.textColor = UIColor.darkPurple
//                pomodoroLabel.backgroundColor = .clear
//                pomodoroLabel.textColor = UIColor.lightTextColor
//                shortBreakLabel.backgroundColor = .clear
//                shortBreakLabel.textColor = UIColor.lightTextColor
//            }
//            setStartTime(date: Date())
//            startTimer()
//            currentState += 1
//            startAnimation()
//        } else {
//            resetTimer()
//        }
//    }
//
//    func resetTimer() {
//        shapeLayer.removeAllAnimations()
//        shapeLayer.removeAnimation(forKey: "animation")
//        currentState = 1
//        totalSeconds = 0
//        totalSeconds = pomodoroSeconds
//        setStartTime(date: nil)
//        setStopTime(date: nil)
//        stopTimer()
//        setTimeLabel(pomodoroSeconds)
//        /// We are back in the pomodoroTheme Colors
//        pomodoroLabel.backgroundColor = pickedColor
//        pomodoroLabel.textColor = UIColor.darkPurple
//        shortBreakLabel.backgroundColor = .clear
//        shortBreakLabel.textColor = UIColor.lightTextColor
//        longBreakLabel.backgroundColor = .clear
//        longBreakLabel.textColor = UIColor.lightTextColor
//
//    }
//
//
//
//    // MARK: - Adding Subviews
//
    func createSubviews() {

        addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.07).isActive = true

        addSubview(timerStateStackView)
        timerStateStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        timerStateStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        timerStateStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30).isActive = true
        timerStateStackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.08).isActive = true
      
        addSubview(timerView)
        timerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        timerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        timerView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        timerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.35).isActive = true
        timerView.heightAnchor.constraint(equalTo: timerView.widthAnchor).isActive = true
        



//
//
//
//
//
//        addSubview(shadowView)
//
//
//        timerView.addSubview(lightPurpleCircleView)
//        lightPurpleCircleView.centerXAnchor.constraint(equalTo: timerView.centerXAnchor).isActive = true
//        lightPurpleCircleView.centerYAnchor.constraint(equalTo: timerView.centerYAnchor).isActive = true
//        lightPurpleCircleView.heightAnchor.constraint(equalTo: timerView.heightAnchor).isActive = true
//        lightPurpleCircleView.widthAnchor.constraint(equalTo: timerView.heightAnchor).isActive = true
//
//
//        shadowView.centerXAnchor.constraint(equalTo: timerView.centerXAnchor).isActive = true
//        shadowView.centerYAnchor.constraint(equalTo: timerView.centerYAnchor).isActive = true
//        shadowView.heightAnchor.constraint(equalTo: timerView.heightAnchor).isActive = true
//        shadowView.widthAnchor.constraint(equalTo: timerView.heightAnchor).isActive = true
//
//        timerView.addSubview(darkPurpleCircleView)
//        darkPurpleCircleView.centerXAnchor.constraint(equalTo: timerView.centerXAnchor).isActive = true
//        darkPurpleCircleView.centerYAnchor.constraint(equalTo: timerView.centerYAnchor).isActive = true
//        darkPurpleCircleView.heightAnchor.constraint(equalTo: timerView.heightAnchor, constant: -30).isActive = true
//        darkPurpleCircleView.widthAnchor.constraint(equalTo: timerView.heightAnchor, constant: -30).isActive = true
//
//
//
//        timerView.addSubview(timerLabel)
//        timerLabel.centerYAnchor.constraint(equalTo: timerView.centerYAnchor, constant: -10).isActive = true
//        timerLabel.centerXAnchor.constraint(equalTo: timerView.centerXAnchor).isActive = true
//
//        timerView.addSubview(startStopLabel)
//        startStopLabel.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 17).isActive = true
//        startStopLabel.centerXAnchor.constraint(equalTo: timerView.centerXAnchor).isActive = true
//
        addSubview(settingsButton)
        settingsButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        settingsButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        settingsButton.heightAnchor.constraint(equalToConstant: 28).isActive = true
        settingsButton.widthAnchor.constraint(equalToConstant: 28).isActive = true

    }
    
    private func setupSettingsView() {

        addSubview(newSettingsView)
        newSettingsView.anchor(top: safeAreaLayoutGuide.topAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 15, left: 15, bottom: -40, right: -15))
        
    }
    
}
    
  
    


