//
//  ViewController.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 15/10/2021.
//
import UIKit

class PomodoroViewController: UIViewController {
    
    lazy var shapeLayer = CAShapeLayer()
    var isAnimatingFirstTime = true
    
    var secondsRemaining = 0
    var pomodoroSeconds = 4
    var shortBreakSeconds = 2
    var longBreakSeconds = 3
    
    var timer = Timer()
    var isCounting = false
    
    var currentInterval = 1
    
    var labelColor = ColorManager.pomodoroOrange {
        didSet {
            shapeLayer.strokeColor = labelColor.cgColor
        }
    }
    
    // does it always have to have a values?
    var customizedFont: String = "MalayalamSangamMN" {
        didSet {
            titleLabel.font = UIFont(name: customizedFont, size: titleLabel.font.pointSize)
            pomodoroLabel.font = UIFont(name: customizedFont, size: pomodoroLabel.font.pointSize)
            shortBreakLabel.font = UIFont(name: customizedFont, size: shortBreakLabel.font.pointSize)
            longBreakLabel.font = UIFont(name: customizedFont, size: longBreakLabel.font.pointSize)
            startStop.font = UIFont(name: customizedFont, size: startStop.font.pointSize)
            timerLabel.font = UIFont(name: customizedFont, size: timerLabel.font.pointSize)
        }
    }
    
    enum TimeIntervals {
        case pomodoro
        case shortBreak
        case longBreak
    }
    let intervals: [TimeIntervals] = [.pomodoro, .shortBreak, .pomodoro, .shortBreak, .pomodoro, .longBreak]

    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.backgroundColor = .blue
        label.text = "pomodoro"
        label.textAlignment = .center
        label.textColor = .white
        let fontName = "MalayalamSangamMN"
        label.font = UIFont(name: fontName, size: 24)
//        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    let intervalsBackgroundLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .green
        label.layer.cornerRadius = 30
        label.layer.masksToBounds = true
        return label
    }()
    
    let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "00:06"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 50)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        //label.backgroundColor = .red
        return label
    }()
    
    
    // lazy var "business" here is needed otherwise "addGestureRecignizer" doesn't work
    
    lazy var startStop: UILabel = {
        let label = UILabel()
        label.text = "START"
        label.textAlignment = .center
//        label.font = UIFont(name: "MalayalamSangamMN", size: 24)
        label.font = label.font.withSize(24)
//        label.font. = UIFont("MalayalamSangamMN")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(startStopTapped)))
        //label.backgroundColor = .cyan
        return label
    }()
    
    let timerView: UIView = {
        let view = UIView()
//        view.backgroundColor = #colorLiteral(red: 0.139921248, green: 0.1541073918, blue: 0.3137726188, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var settingsIconView: UIImageView = {
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
    
    // why lazy var and why st.pomodoroVC = self???
    
    lazy var settingsLauncher: SettingsLauncher = {
        let st = SettingsLauncher()
        st.pomodoroVC = self
        return st
    }()
    
    func setupSettingsLauncher() {
    
        view.addSubview(settingsLauncher)
        
//        settingsLauncher.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 280).isActive = true
//        settingsLauncher.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80).isActive = true
//        settingsLauncher.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
//        settingsLauncher.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
        
        settingsLauncher.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        settingsLauncher.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
        settingsLauncher.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        settingsLauncher.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
    }
    
    @objc func settingsIconTapped() {
        setupSettingsLauncher()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        secondsRemaining = pomodoroSeconds
    }

    func resetToBeginning() {
        currentInterval = 0
        secondsRemaining = 0
        secondsRemaining = pomodoroSeconds
        startStop.text = "START"
        isCounting = false
        shapeLayer.removeAllAnimations()
        pomodoroLabel.backgroundColor = labelColor
        pomodoroLabel.textColor = ColorManager.darkPurple
        longBreakLabel.backgroundColor = .clear
        longBreakLabel.textColor = ColorManager.lightTextColor
    }
    // Function setupAnimation can be fire only once thus it can't be in the viewDidLayoutSubviews as it is fired every time when UI changes (label or rotation of the screen)
    
    
    // This method is needed to call setupTimierAnimation() only once after view is loaded and we can set up the size of the circle based on the UIView size. In viewDidLoad() this function doesn't work as the seize of the view is unknown at that time
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupTimerShape()
    
    }
//
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        super.viewWillTransition(to: size, with: coordinator)
//    }
    
    
// MARK: Circle Timer Functions
    
    
    func setupTimerShape() {

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
        
        // apparently it is bad practise to set "isRemovedOnCompletion = false"
//        circleAnimation.isRemovedOnCompletion = false
        shapeLayer.add(circleAnimation, forKey: "animation")
    }
    
    func pauseAnimation() {
        let pausedTime: CFTimeInterval = shapeLayer.convertTime(CACurrentMediaTime(), from: nil)
        shapeLayer.speed = 0.0
        shapeLayer.timeOffset = pausedTime
        isAnimatingFirstTime = false

    }

    func resumeAnimation() {
        let pausedTime = shapeLayer.timeOffset
        shapeLayer.speed = 1.0
        shapeLayer.timeOffset = 0.0
        shapeLayer.beginTime = 0.0
        shapeLayer.strokeEnd = 1.0
        let timeSincePause = shapeLayer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        shapeLayer.beginTime = timeSincePause
        
    }
    
    func startResumeAnimation() {
        if isAnimatingFirstTime {
            startAnimation()
            isAnimatingFirstTime = false
        
        } else {
            resumeAnimation()
            isAnimatingFirstTime = true
        }
    }

    // MARK: Timer functions
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
    }
    
    @objc func startStopTapped() {
        if isCounting {
            isCounting = false
            timer.invalidate()
            startStop.text = "START"
            pauseAnimation()
        }
        else {
            isCounting = true
            startStop.text = "PAUSE"
            startResumeAnimation()
            
// we had to inform that next interval is about to start. Otherwise pomodoro time will run twice
            if currentInterval == 0 && secondsRemaining == pomodoroSeconds {
                startNextInterval()
            } else {
                startTimer()
            }
        }
    }

    @objc func timerCounter() {
        if secondsRemaining > 1 {
            secondsRemaining -= 1
        } else {
            timer.invalidate()
            startNextInterval()
            isAnimatingFirstTime = true

        }
        timerLabel.text = timeString(time: TimeInterval(secondsRemaining))
    }
    
    
    func startNextInterval() {

      if currentInterval < intervals.count  {
          if intervals[currentInterval] == .pomodoro {
            secondsRemaining = pomodoroSeconds
              pomodoroLabel.backgroundColor = labelColor
              pomodoroLabel.textColor = ColorManager.darkPurple
              shortBreakLabel.backgroundColor = .clear
              shortBreakLabel.textColor = ColorManager.lightTextColor
              longBreakLabel.backgroundColor = .clear
              longBreakLabel.textColor = ColorManager.lightTextColor

          } else if intervals[currentInterval] == .shortBreak {
            secondsRemaining = shortBreakSeconds
              shortBreakLabel.backgroundColor = labelColor
              shortBreakLabel.textColor = ColorManager.darkPurple
              pomodoroLabel.backgroundColor = .clear
              pomodoroLabel.textColor = ColorManager.lightTextColor
              longBreakLabel.backgroundColor = .clear
              longBreakLabel.textColor = ColorManager.lightTextColor

          } else if intervals[currentInterval] == .longBreak {
             secondsRemaining = longBreakSeconds
              longBreakLabel.backgroundColor = labelColor
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
    
    func timeString(time: TimeInterval) -> String {
//        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%.2d:%.2d", minutes, seconds)
    }
    
    func didUpdateTimer(with pomodoroTime: Int, with shortBreakTime: Int, with longBreakTime: Int) {
        
        timerLabel.text =  "\(pomodoroTime):00"
        pomodoroSeconds = pomodoroTime * 60
        shortBreakSeconds = shortBreakTime * 60
        longBreakSeconds = longBreakTime * 60
        timer.invalidate()
        startStop.text = "START"
        resetToBeginning()
        
    }
    
        let pomodoroLabel: UILabel = {
            let label = UILabel()
            label.backgroundColor = ColorManager.pomodoroOrange
            label.layer.cornerRadius = 28.0
            label.layer.masksToBounds = true
            label.text = "pomodoro"
            label.textAlignment = .center
            label.textColor = ColorManager.darkPurple
            label.font = UIFont(name: "MalayalamSangamMN", size: 18)
            return label
        }()
        
        let shortBreakLabel: UILabel = {
            let label = UILabel()
//            label.backgroundColor = .red
            label.layer.cornerRadius = 28.0
            label.layer.masksToBounds = true
            label.text = "short break"
            label.textAlignment = .center
            label.textColor = ColorManager.lightTextColor
            label.font = UIFont.boldSystemFont(ofSize: 18)
            return label
            
        }()
        
        let longBreakLabel: UILabel = {
            let label = UILabel()
//            label.backgroundColor = .blue
            label.layer.cornerRadius = 28.0
            label.layer.masksToBounds = true
            label.text = "long break"
            label.textAlignment = .center
            label.textColor = ColorManager.lightTextColor
            label.font = UIFont.boldSystemFont(ofSize: 18)
            return label
            
        }()
    func setupStackView() {
        
        let stackView = UIStackView(arrangedSubviews: [pomodoroLabel, shortBreakLabel, longBreakLabel])
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.layer.cornerRadius = 28
        stackView.layer.masksToBounds = true
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 6, left: 4, bottom: 6, right: 4)
        stackView.backgroundColor = ColorManager.darkPurple
//        stackView.backgroundColor = #colorLiteral(red: 0.08357880265, green: 0.09788595885, blue: 0.1973884106, alpha: 1)
        
        
        
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30).isActive = true
        stackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08).isActive = true
        
    }
    func setupLayout() {
        view.backgroundColor = ColorManager.backgroundPurple
        view.addSubview(timerView)
        
        
        timerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        timerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        timerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        timerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true

        view.addSubview(titleLabel)
        
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07).isActive = true
        
        timerView.addSubview(timerLabel)
        
        timerLabel.centerYAnchor.constraint(equalTo: timerView.centerYAnchor).isActive = true
        timerLabel.centerXAnchor.constraint(equalTo: timerView.centerXAnchor).isActive = true
        
        timerView.addSubview(startStop)
        
        startStop.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 20).isActive = true
        startStop.centerXAnchor.constraint(equalTo: timerView.centerXAnchor).isActive = true
        
        view.addSubview(settingsIconView)
        
        settingsIconView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        settingsIconView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        settingsIconView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        settingsIconView.widthAnchor.constraint(equalToConstant: 35).isActive = true
        
        setupStackView()
        
    }
}


