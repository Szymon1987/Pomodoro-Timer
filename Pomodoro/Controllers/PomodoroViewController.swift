//
//  ViewController.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 15/10/2021.
//
import UIKit

class PomodoroViewController: UIViewController {
    
    var shareView = PomodoroTimerView()
    
    override func loadView() {
        view = shareView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupLayout()
        shareView.totalSeconds = shareView.pomodoroSeconds
//        shareView.setupRoundedViews()
//        shareView.setupTimerView()
        
        
//        startTime = userDefaults.object(forKey: START_TIME_KEY) as? Date
//        stopTime = userDefaults.object(forKey: STOP_TIME_KEY) as? Date
//        timerCounting = userDefaults.bool(forKey: COUNTING_KEY)
        
        
        
        
//        totalSeconds = pomodoroSeconds
        
        
//        if timerCounting {
//            startTimer()
//        } else {
//            stopTimer()
//            if let start = startTime {
//                if let stop = stopTime {
//                    let time = calculateRestartTime(start: start, stop: stop)
//                    let difference = Date().timeIntervalSince(time)
//                    setTimeLabel(Int(difference))
//                }
//            }
//        }

    }
    
    
    
//    enum TimeIntervals {
//        case pomodoro
//        case shortBreak
//        case longBreak
//    }
//    private let intervals: [TimeIntervals] = [.pomodoro, .shortBreak, .pomodoro, .longBreak]
//
//    var totalSeconds: Int = 6
//    var pomodoroSeconds: Int = 6
//    var shortBreakSeconds: Int = 2
//    var longBreakSeconds: Int = 4
//
//    var timerCounting: Bool = false
//    var startTime: Date?
//    var stopTime: Date?
//    var scheduledTimer: Timer!
//    var currentInterval: Int = 1
//    private var colorTheme: UIColor = ColorManager.pomodoroOrange
//    private var fontTheme: String = "MalayalamSangamMN"
//
//
//    let userDefaults = UserDefaults.standard
//    let START_TIME_KEY = "startTime"
//    let STOP_TIME_KEY = "stopTime"
//    let COUNTING_KEY = "countingKey"
    
//
//    // MARK: - Constants
//    private let start: String = "S T A R T"
//    private let pause: String = "P A U S E"
//
//    // MARK: - Properties
//
//    private lazy var settingsView: SettingsView = {
//        let st = SettingsView()
//        st.pomodoroVC = self
//        return st
//    }()
    
    // MARK: - LifeCycle
    
   
   
 
    
    
    
    
      // it isn't probaly correct function
    
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        [pomodoroLabel, shortBreakLabel, longBreakLabel].forEach {$0.layer.cornerRadius = pomodoroLabel.frame.height / 2}
//        intervalsBackgroundView.layer.cornerRadius = intervalsBackgroundView.frame.height / 2
//        setupTimerView()
//        setupRoundedViews()
//    }
    
    
    
    
    
//
//    // MARK: - GradientLayer Views
//
//    lazy var roundedGradient: CAGradientLayer = {
//        let gradient = CAGradientLayer()
//        gradient.startPoint = CGPoint(x: 0, y: 0)
//        gradient.endPoint = CGPoint(x: 1, y: 1)
//        gradient.colors = [ColorManager.darkPurple.cgColor, ColorManager.backgroundPurpleLight.cgColor]
//        gradient.locations = [0.2, 1]
//        return gradient
//    }()
//
//    let darkPurpleCircleView: UIView = {
//        let view = UIView()
//        view.backgroundColor = ColorManager.darkPurple
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//
//    let lightPurpleCircleView: UIView = {
//        let view = UIView()
//        view.clipsToBounds = true
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//
//    let shadowView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = ColorManager.darkPurple
//        view.layer.masksToBounds = false
//        return view
//    }()
//
//
//    // MARK: - UIComponents
//
//    private var titleLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "pomodoro"
//        label.textAlignment = .center
//        label.textColor = .white
//        let fontName = "MalayalamSangamMN-Bold"
//        label.font = UIFont(name: fontName, size: 24)
//        return label
//    }()
//
//    private let intervalsBackgroundView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = ColorManager.darkPurple
//        view.layer.masksToBounds = true
//        return view
//    }()
//
//    private let pomodoroLabel: UILabel = {
//        let label = UILabel()
//        label.backgroundColor = ColorManager.pomodoroOrange
//        label.layer.masksToBounds = true
//        label.text = "pomodoro"
//        label.textAlignment = .center
//        label.textColor = ColorManager.darkPurple
//        label.font = UIFont(name: "MalayalamSangamMN-Bold", size: 18)
//        return label
//    }()
//
//    private let shortBreakLabel: UILabel = {
//        let label = UILabel()
//            label.backgroundColor = .clear
//        label.layer.masksToBounds = true
//        label.text = "short break"
//        label.textAlignment = .center
//        label.textColor = ColorManager.lightTextColor
//        label.font = UIFont(name: "MalayalamSangamMN-Bold", size: 18)
////        label.font = UIFont.boldSystemFont(ofSize: 18)
//        return label
//    }()
//
//
//    private let longBreakLabel: UILabel = {
//        let label = UILabel()
//        label.layer.masksToBounds = true
//        label.text = "long break"
//        label.textAlignment = .center
//        label.textColor = ColorManager.lightTextColor
//        label.font = UIFont(name: "MalayalamSangamMN-Bold", size: 18)
////        label.font = UIFont.boldSystemFont(ofSize: 18)
//        return label
//    }()
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
//
//    private lazy var startStopLabel: UILabel = {
//        let label = UILabel()
//        label.text = start
//        label.textAlignment = .center
//        label.font = UIFont(name: "MalayalamSangamMN-Bold", size: 22)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.textColor = .white
//        label.isUserInteractionEnabled = true
//        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(startStopTapped)))
//        return label
//    }()
//
//    private let timerView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//
//    lazy var shapeLayer: CAShapeLayer = {
//        let layer = CAShapeLayer()
//        layer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
//        layer.strokeColor = ColorManager.pomodoroOrange.cgColor
//        layer.lineWidth = 10
//        layer.fillColor = UIColor.clear.cgColor
//        layer.lineCap = .round
//        layer.strokeEnd = 1
//        return layer
//    }()
//
//    private lazy var settingsButton: UIButton = {
//        let button = UIButton()
//        let image = UIImage(named: "settingsIcon")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
//        button.setImage(image, for: .normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(settingsIconTapped)))
//        return button
//    }()
        
    // MARK: - SettingUp The Views Methods

//    private func setupSettingsView() {
//        
//        view.addSubview(settingsView)
//        settingsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
//        settingsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
//        settingsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
//        settingsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
//    }
    
//    private func setupTopLabelsStackView() {
//        
//        view.addSubview(intervalsBackgroundView)
//        intervalsBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
//        intervalsBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
//        intervalsBackgroundView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30).isActive = true
//        intervalsBackgroundView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08).isActive = true
//        
//        let stackView = UIStackView(arrangedSubviews: [pomodoroLabel, shortBreakLabel, longBreakLabel])
//        intervalsBackgroundView.addSubview(stackView)
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.distribution = .fillEqually
//        stackView.layer.masksToBounds = true
//        stackView.isLayoutMarginsRelativeArrangement = true
//        stackView.layoutMargins = UIEdgeInsets(top: 7, left: 10, bottom: 7, right: 10)
//        
//        stackView.anchorSize(to: intervalsBackgroundView)
//    }
    
//    private func setupLayout() {
        
//        view.backgroundColor = ColorManager.backgroundPurple
//
//        view.addSubview(shadowView)
//        view.addSubview(timerView)
//
//        timerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        timerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        timerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        timerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.40).isActive = true
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
//        view.addSubview(titleLabel)
//        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//        titleLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07).isActive = true
//
//        timerView.addSubview(timerLabel)
//        timerLabel.centerYAnchor.constraint(equalTo: timerView.centerYAnchor, constant: -10).isActive = true
//        timerLabel.centerXAnchor.constraint(equalTo: timerView.centerXAnchor).isActive = true
//
//        timerView.addSubview(startStopLabel)
//        startStopLabel.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 17).isActive = true
//        startStopLabel.centerXAnchor.constraint(equalTo: timerView.centerXAnchor).isActive = true
//
//        view.addSubview(settingsButton)
//        settingsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
//        settingsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        settingsButton.heightAnchor.constraint(equalToConstant: 28).isActive = true
//        settingsButton.widthAnchor.constraint(equalToConstant: 28).isActive = true
//
//        setupTopLabelsStackView()
//    }
    
//    // MARK: - UIActions
//
//    @objc private func settingsIconTapped() {
//        Haptics.playLightImpact()
//        setupSettingsView()
//    }
//    
//    private func setupRoundedViews() {
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
//        shadowView.layer.shadowColor = ColorManager.backgroundPurpleLight.cgColor
//        
//        shadowView.layer.rasterizationScale = UIScreen.main.scale
//        shadowView.layer.shadowRadius = 40
//        shadowView.layer.shadowOpacity = 0.5
//        shadowView.layer.shadowOffset = CGSize(width: -25, height: -40)
//    }
//    
//    private func setupTimerView() {
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
//
//    // MARK: - Animation Methods
//
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
// 
//    
//    // MARK: Timer functions
//
//    func didUpdateUI(with pomodoroMinutes: Int, with shortBreakMinutes: Int, with longBreakMinutes: Int, font: String, color: UIColor) {
//        
//        self.resetTimer()
//        self.pomodoroSeconds = pomodoroMinutes * 60
//        self.shortBreakSeconds = shortBreakMinutes * 60
//        self.longBreakSeconds = longBreakMinutes * 60
//        self.fontTheme = font
//        self.colorTheme = color
//        
//        DispatchQueue.main.async {
//                self.pomodoroLabel.backgroundColor = color
//                self.shapeLayer.strokeColor = color.cgColor
//            self.titleLabel.font = UIFont(name: font, size: self.titleLabel.font.pointSize)
//                self.pomodoroLabel.font = UIFont(name: self.fontTheme, size: self.pomodoroLabel.font.pointSize)
//                self.shortBreakLabel.font = UIFont(name: self.fontTheme, size: self.shortBreakLabel.font.pointSize)
//                self.longBreakLabel.font = UIFont(name: self.fontTheme, size: self.longBreakLabel.font.pointSize)
//                self.timerLabel.font = UIFont(name: self.fontTheme, size: self.timerLabel.font.pointSize)
//                self.startStopLabel.font = UIFont(name: self.fontTheme, size: self.startStopLabel.font.pointSize)
//                self.resetTimer()
//        }
//    }
//
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
//        userDefaults.set(startTime, forKey: START_TIME_KEY)
//    }
//    
//    func setStopTime(date: Date?) {
//        stopTime = date
//        userDefaults.set(stopTime, forKey: STOP_TIME_KEY)
//    }
//    func setTimerCounting(_ val: Bool) {
//        timerCounting = val
//        userDefaults.set(timerCounting, forKey: COUNTING_KEY)
//    }
//    
//    func switchInterval() {
//        if currentInterval < intervals.count {
//            switch intervals[currentInterval] {
//            case .pomodoro:
//                totalSeconds = pomodoroSeconds
//                pomodoroLabel.backgroundColor = colorTheme
//                pomodoroLabel.textColor = ColorManager.darkPurple
//                shortBreakLabel.backgroundColor = .clear
//                shortBreakLabel.textColor = ColorManager.lightTextColor
//                longBreakLabel.backgroundColor = .clear
//                longBreakLabel.textColor = ColorManager.lightTextColor
//            case .shortBreak:
//                totalSeconds = shortBreakSeconds
//                shortBreakLabel.backgroundColor = colorTheme
//                shortBreakLabel.textColor = ColorManager.darkPurple
//                pomodoroLabel.backgroundColor = .clear
//                pomodoroLabel.textColor = ColorManager.lightTextColor
//                longBreakLabel.backgroundColor = .clear
//                longBreakLabel.textColor = ColorManager.lightTextColor
//            case .longBreak:
//                totalSeconds = longBreakSeconds
//                longBreakLabel.backgroundColor = colorTheme
//                longBreakLabel.textColor = ColorManager.darkPurple
//                pomodoroLabel.backgroundColor = .clear
//                pomodoroLabel.textColor = ColorManager.lightTextColor
//                shortBreakLabel.backgroundColor = .clear
//                shortBreakLabel.textColor = ColorManager.lightTextColor
//            }
//            setStartTime(date: Date())
//            startTimer()
//            currentInterval += 1
//            startAnimation()
//        } else {
//            resetTimer()
//        }
//    }
//    
//    func resetTimer() {
//        shapeLayer.removeAllAnimations()
//        shapeLayer.removeAnimation(forKey: "animation")
//        currentInterval = 1
//        totalSeconds = 0
//        totalSeconds = pomodoroSeconds
//        setStartTime(date: nil)
//        setStopTime(date: nil)
//        stopTimer()
//        setTimeLabel(pomodoroSeconds)
//        /// We are back in the pomodoroTheme Colors
//        pomodoroLabel.backgroundColor = colorTheme
//        pomodoroLabel.textColor = ColorManager.darkPurple
//        shortBreakLabel.backgroundColor = .clear
//        shortBreakLabel.textColor = ColorManager.lightTextColor
//        longBreakLabel.backgroundColor = .clear
//        longBreakLabel.textColor = ColorManager.lightTextColor
//        
//    }


}


