//
//  ViewController.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 15/10/2021.
//
import UIKit

class PomodoroViewController: UIViewController {
    
    // MARK: - Properties
    private let start: String = "S T A R T"
    private let pause: String = "P A U S E"
    
    private var shapeLayer = CAShapeLayer()
    private var isAnimatingFirstTime = true
    
    private var secondsRemaining = 0
    private var pomodoroSeconds = 4
    private var shortBreakSeconds = 2
    private var longBreakSeconds = 3
    
    private var timer = Timer()
    private var isCounting = false
    
    private var currentInterval = 1
    
    enum TimeIntervals {
        case pomodoro
        case shortBreak
        case longBreak
    }
    private let intervals: [TimeIntervals] = [.pomodoro, .shortBreak, .pomodoro, .shortBreak, .pomodoro, .longBreak]
        
    var customizedFont: String = "MalayalamSangamMN" {
        didSet {
            titleLabel.font = UIFont(name: customizedFont, size: titleLabel.font.pointSize)
            pomodoroLabel.font = UIFont(name: customizedFont, size: pomodoroLabel.font.pointSize)
            shortBreakLabel.font = UIFont(name: customizedFont, size: shortBreakLabel.font.pointSize)
            longBreakLabel.font = UIFont(name: customizedFont, size: longBreakLabel.font.pointSize)
            startStopLabel.font = UIFont(name: customizedFont, size: startStopLabel.font.pointSize)
            timerLabel.font = UIFont(name: customizedFont, size: timerLabel.font.pointSize)
        }
    }
    
    var themeColor = ColorManager.pomodoroOrange {
        didSet {
                shapeLayer.strokeColor = themeColor.cgColor
            print(themeColor.cgColor)
                changeLabelBackgroundColor()
        }
    }
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        secondsRemaining = pomodoroSeconds
    }
  
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        [pomodoroLabel, shortBreakLabel, longBreakLabel].forEach {$0.layer.cornerRadius = pomodoroLabel.frame.height / 2}
        intervalsBackgroundView.layer.cornerRadius = intervalsBackgroundView.frame.height / 2
        setupTimerShape()
    }

    //MARK: - UIComponents
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.backgroundColor = .blue
        label.text = "pomodoro"
        label.textAlignment = .center
        label.textColor = .white
        let fontName = "MalayalamSangamMN"
        label.font = UIFont(name: fontName, size: 24)
        return label
    }()
    
    private let intervalsBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ColorManager.darkPurple
        view.layer.masksToBounds = true
        return view
    }()
    
    private let pomodoroLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = ColorManager.pomodoroOrange
        label.layer.masksToBounds = true
        label.text = "pomodoro"
        label.textAlignment = .center
        label.textColor = ColorManager.darkPurple
        label.font = UIFont(name: "MalayalamSangamMN", size: 18)
        return label
    }()
    
    private let shortBreakLabel: UILabel = {
        let label = UILabel()
            label.backgroundColor = .clear
        label.layer.masksToBounds = true
        label.text = "short break"
        label.textAlignment = .center
        label.textColor = ColorManager.lightTextColor
        label.font = UIFont(name: "MalayalamSangamMN", size: 18)
//        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let longBreakLabel: UILabel = {
        let label = UILabel()
        label.layer.masksToBounds = true
        label.text = "long break"
        label.textAlignment = .center
        label.textColor = ColorManager.lightTextColor
        label.font = UIFont(name: "MalayalamSangamMN", size: 18)
//        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "00:06"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 54)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()

    private lazy var startStopLabel: UILabel = {
        let label = UILabel()
        label.text = start
        label.textAlignment = .center
//        label.font = UIFont(name: "MalayalamSangamMN", size: 24)
        label.font = label.font.withSize(22)
//        label.font. = UIFont("MalayalamSangamMN")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(startStopTapped)))
        //label.backgroundColor = .cyan
        return label
    }()
    
    private let timerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var settingsIconView: UIImageView = {
        let image = UIImage(systemName: "gearshape.fill")
        let imageView = UIImageView(image: image)
        imageView.image?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(settingsIconTapped)))
        return imageView
    }()
    
    // why lazy var and why st.pomodoroVC = self??? check if st.pomodoroVC = self is needed here
    
    private lazy var settingsView: SettingsView = {
        let st = SettingsView()
        st.pomodoroVC = self
        return st
    }()
    
    //MARK: - SettingUp The Views Methods
//    var topSpace: NSLayoutConstraint?
//    var bottomSpace: NSLayoutConstraint?
//    var leftSpace: NSLayoutConstraint?
//    var rightSpace: NSLayoutConstraint?
//
//    func animate() {
//        topSpace?.constant = 20
//        bottomSpace?.constant = -40
//        leftSpace?.constant = 15
//        rightSpace?.constant = -15
//        UIView.animate(withDuration: 1.0,
//                       delay: 1,
//                       options: .curveEaseIn,
//                       animations: {
//                        self.view.layoutIfNeeded()
//        },
//                       completion: nil)
//    }
//
    private func setupSettingsView() {
        view.addSubview(settingsView)
  
//        topSpace = settingsLauncher.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200)
//        topSpace?.isActive = true
//        bottomSpace = settingsLauncher.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -200)
//        bottomSpace?.isActive = true
//        leftSpace = settingsLauncher.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 100)
//        leftSpace?.isActive = true
//        rightSpace = settingsLauncher.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -100)
//        rightSpace?.isActive = true

//        settingsLauncher.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200).isActive = true
//        settingsLauncher.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -200).isActive = true
//        settingsLauncher.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 100).isActive = true
//        settingsLauncher.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -100).isActive = true

        settingsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        settingsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
        settingsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        settingsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
    }
    
    private func setupStackView() {
        
        view.addSubview(intervalsBackgroundView)
        intervalsBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        intervalsBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        intervalsBackgroundView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30).isActive = true
        intervalsBackgroundView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [pomodoroLabel, shortBreakLabel, longBreakLabel])
        intervalsBackgroundView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.layer.masksToBounds = true
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 7, left: 10, bottom: 7, right: 10)
        
        stackView.anchorSize(to: intervalsBackgroundView)
    }
    private func setupLayout() {
        view.backgroundColor = ColorManager.backgroundPurple
        view.addSubview(timerView)
        
        
        timerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        timerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        timerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        timerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.32).isActive = true

        view.addSubview(titleLabel)
        
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07).isActive = true
        
        timerView.addSubview(timerLabel)
        
        timerLabel.centerYAnchor.constraint(equalTo: timerView.centerYAnchor).isActive = true
        timerLabel.centerXAnchor.constraint(equalTo: timerView.centerXAnchor).isActive = true
        
        timerView.addSubview(startStopLabel)
        
        startStopLabel.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 20).isActive = true
        startStopLabel.centerXAnchor.constraint(equalTo: timerView.centerXAnchor).isActive = true
        
        view.addSubview(settingsIconView)
        
        settingsIconView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        settingsIconView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        settingsIconView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        settingsIconView.widthAnchor.constraint(equalToConstant: 35).isActive = true
        
        setupStackView()
        
    }
    
    //MARK: - Helpers
    
    @objc private func settingsIconTapped() {
        Haptics.playLightImpact()
        setupSettingsView()
//        animate()
    }
    
    private func changeLabelBackgroundColor() {
        
        let labels = [pomodoroLabel, shortBreakLabel, longBreakLabel]
        for label in labels {
            if label.backgroundColor != .clear {
                label.backgroundColor = themeColor
            } else {
                label.backgroundColor = .clear
            }
        }
//        if currentInterval == 0 || currentInterval == 1 || currentInterval ==
//
//        if pomodoroVC.currentInterval == 0 || pomodoroVC.currentInterval == 1 || pomodoroVC.currentInterval == 3 || pomodoroVC.currentInterval == 5 {
//            pomodoroVC.pomodoroLabel.backgroundColor = senderColor
//        } else if pomodoroVC.currentInterval == 2 || pomodoroVC.currentInterval == 4 {
//            pomodoroVC.shortBreakLabel.backgroundColor = senderColor
//        } else if pomodoroVC.currentInterval == 6 {
//            pomodoroVC.longBreakLabel.backgroundColor = senderColor
//        }
//    }
    }

// MARK: Circle Timer Functions
    
    private func setupTimerShape() {

        let radius = timerView.frame.height / 2
        let circularPath = UIBezierPath(arcCenter: .zero, radius: radius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        shapeLayer.path = circularPath.cgPath

        
        // had to reposition to the center otherwise there is a bug in the animation when originally setting "startAngle" to -CGFloat.pi / 2
        
        let center = CGPoint(x: timerView.layer.bounds.midX, y: timerView.layer.bounds.midY)
        shapeLayer.position = center
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        shapeLayer.strokeColor = ColorManager.pomodoroOrange.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = .round
        shapeLayer.strokeEnd = 1
        timerView.layer.addSublayer(shapeLayer)
    }

    
    // should circleAnimation be inside the startAnimation()?
    private let circleAnimation = CABasicAnimation(keyPath: "strokeEnd")
    
    private func startAnimation() {
        circleAnimation.fromValue = 1
        circleAnimation.toValue = 0
        circleAnimation.duration = CFTimeInterval(secondsRemaining)
        
        // apparently it is a bad practise to set "isRemovedOnCompletion = false"
//        circleAnimation.isRemovedOnCompletion = false
        shapeLayer.add(circleAnimation, forKey: "animation")
    }
    
    private func pauseAnimation() {
        let pausedTime: CFTimeInterval = shapeLayer.convertTime(CACurrentMediaTime(), from: nil)
        shapeLayer.speed = 0.0
        shapeLayer.timeOffset = pausedTime
        isAnimatingFirstTime = false

    }

    private func resumeAnimation() {
        let pausedTime = shapeLayer.timeOffset
        shapeLayer.speed = 1.0
        shapeLayer.timeOffset = 0.0
        shapeLayer.beginTime = 0.0
        shapeLayer.strokeEnd = 1.0
        let timeSincePause = shapeLayer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        shapeLayer.beginTime = timeSincePause
    }
    
    private func startResumeAnimation() {
        if isAnimatingFirstTime {
            startAnimation()
            isAnimatingFirstTime = false
        } else {
            resumeAnimation()
            isAnimatingFirstTime = true
        }
    }

    // MARK: Timer functions
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
    }
    
    @objc private func startStopTapped() {
        Haptics.playLightImpact()
        if isCounting {
            isCounting = false
            timer.invalidate()
            startStopLabel.text = start
            pauseAnimation()
        }
        else {
            isCounting = true
            startStopLabel.text = pause
            startResumeAnimation()
            
// we have to inform that next interval is about to start. Otherwise pomodoro time will run twice
            if currentInterval == 0 && secondsRemaining == pomodoroSeconds {
                startNextInterval()
            } else {
                startTimer()
            }
        }
    }

    @objc private func timerCounter() {
        if secondsRemaining > 1 {
            secondsRemaining -= 1
        } else {
            timer.invalidate()
            startNextInterval()
            isAnimatingFirstTime = true

        }
        timerLabel.text = timeString(time: TimeInterval(secondsRemaining))
    }
    
    
    private func startNextInterval() {

      if currentInterval < intervals.count  {
          if intervals[currentInterval] == .pomodoro {
            secondsRemaining = pomodoroSeconds
              pomodoroLabel.backgroundColor = themeColor
              pomodoroLabel.textColor = ColorManager.darkPurple
              shortBreakLabel.backgroundColor = .clear
              shortBreakLabel.textColor = ColorManager.lightTextColor
              longBreakLabel.backgroundColor = .clear
              longBreakLabel.textColor = ColorManager.lightTextColor

          } else if intervals[currentInterval] == .shortBreak {
            secondsRemaining = shortBreakSeconds
              shortBreakLabel.backgroundColor = themeColor
              shortBreakLabel.textColor = ColorManager.darkPurple
              pomodoroLabel.backgroundColor = .clear
              pomodoroLabel.textColor = ColorManager.lightTextColor
              longBreakLabel.backgroundColor = .clear
              longBreakLabel.textColor = ColorManager.lightTextColor

          } else if intervals[currentInterval] == .longBreak {
             secondsRemaining = longBreakSeconds
              longBreakLabel.backgroundColor = themeColor
              longBreakLabel.textColor = ColorManager.darkPurple
              pomodoroLabel.backgroundColor = .clear
              pomodoroLabel.textColor = ColorManager.lightTextColor
              shortBreakLabel.backgroundColor = .clear
              shortBreakLabel.textColor = ColorManager.lightTextColor
      }
          currentInterval += 1
          startTimer()
          startAnimation()
      } else {
          resetToBeginning()
      }
        
}
    private func resetToBeginning() {
        currentInterval = 0
        secondsRemaining = 0
        secondsRemaining = pomodoroSeconds
        startStopLabel.text = start
        isCounting = false
        isAnimatingFirstTime = true
        shapeLayer.removeAllAnimations()
        pomodoroLabel.backgroundColor = themeColor
        pomodoroLabel.textColor = ColorManager.darkPurple
        longBreakLabel.backgroundColor = .clear
        longBreakLabel.textColor = ColorManager.lightTextColor
    }
    private func timeString(time: TimeInterval) -> String {
//        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%.2d:%.2d", minutes, seconds)
    }
    
    func didUpdateTimer(with pomodoroTime: Int, with shortBreakTime: Int, with longBreakTime: Int) {
       
        resetToBeginning()
        timerLabel.text =  "\(pomodoroTime):00"
        pomodoroSeconds = pomodoroTime * 60
        shortBreakSeconds = shortBreakTime * 60
        longBreakSeconds = longBreakTime * 60
        timer.invalidate()
        startStopLabel.text = start
    }
}


