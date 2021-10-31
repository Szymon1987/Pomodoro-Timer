//
//  ViewController.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 15/10/2021.
//

import UIKit

class PomodoroViewController: UIViewController {
    
    lazy var shapeLayer = CAShapeLayer()
//    var deafauleTime : Int = 1500
    var secondsRemaining : Int = 1500
    var timer = Timer()
    var isCounting = false
    
    var portrait: [NSLayoutConstraint]?
    var landscape: [NSLayoutConstraint]?
    var isPortrait: Bool = false
   
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.backgroundColor = .blue
        label.text = "pomodoro"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    let menuLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .green
        label.layer.cornerRadius = 30
        label.layer.masksToBounds = true
        return label
    }()
    
    let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "25:00"
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
        label.font = UIFont.boldSystemFont(ofSize: 24)
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
        
        view.backgroundColor = #colorLiteral(red: 0.139921248, green: 0.1541073918, blue: 0.3137726188, alpha: 1)
        setupLayout()
        setupStackView()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

//
//        isPortrait = UIDevice.current.orientation.isPortrait
//    print(isPortrait)
//        if isPortrait {
//            NSLayoutConstraint.deactivate(landscape!)
//            NSLayoutConstraint.activate(portrait!)
//            print("portrait")
//        } else {
//            NSLayoutConstraint.deactivate(portrait!)
//            NSLayoutConstraint.activate(landscape!)
//            print("landscape")
//        }
    }
    
    
    // Function setupAnimation can be fire only once thus it can't be in the viewDidLayoutSubviews as it is fired every time when UI changes (label or rotation of the screen)
    
    
    // This method is needed to call setupTimierAnimation() only once after view is loaded and we can set up the size of the circle based on the UIView size. In viewDidLoad() this function doesn't work as the seize of the view is unknown at that time
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupTimerShape()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    func setupTimerShape() {

        let radius = timerView.frame.height / 2
        let circularPath = UIBezierPath(arcCenter: .zero, radius: radius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        shapeLayer.path = circularPath.cgPath

        
        // had to reposition to the center otherwise there is a bug in the animation when originally setting "startAngle" to -CGFloat.pi / 2
        
        let center = CGPoint(x: timerView.layer.bounds.midX, y: timerView.layer.bounds.midY)
        shapeLayer.position = center
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = .round
        shapeLayer.strokeEnd = 1
        timerView.layer.addSublayer(shapeLayer)
    }

    fileprivate func animateCircle() {
        
        let circleAnimation = CABasicAnimation(keyPath: "strokeEnd")
//        let fromValue =
        circleAnimation.fromValue = 1
        circleAnimation.toValue = 0
        circleAnimation.duration = CFTimeInterval(secondsRemaining)
//        circleAnimation.fillMode = .forwards
        circleAnimation.isRemovedOnCompletion = false
        shapeLayer.add(circleAnimation, forKey: "animation")
    }

    
    @objc func startStopTapped() {
        
        if isCounting {
            isCounting = false
            timer.invalidate()
            startStop.text = "START"
            pauseAnimation()
        }
        else {
            
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
            isCounting = true
            startStop.text = "PAUSE"
            animateCircle()
            resumeAnimation()
        
            
        }
    }
    
    func pauseAnimation() {
        let pausedTime: CFTimeInterval = shapeLayer.convertTime(CACurrentMediaTime(), from: nil)
        shapeLayer.speed = 0.0
        shapeLayer.timeOffset = pausedTime
        print(pausedTime)
    }
    
    func resumeAnimation() {
        let pausedTime = shapeLayer.timeOffset
        shapeLayer.speed = 1.0
        shapeLayer.timeOffset = 0.0
        shapeLayer.beginTime = 0.0
        let timeSincePause = shapeLayer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
//        print(timeSincePause)
//        shapeLayer.beginTime = timeSincePause
        shapeLayer.beginTime = Double(30)
        
    }
    
    @objc func timerCounter() {
        
        if secondsRemaining > 0 {
            secondsRemaining -= 1
        } else {
            timer.invalidate()
            secondsRemaining = 1500
        }
        timerLabel.text = timeString(time: TimeInterval(secondsRemaining))
    }
    
    func timeString(time: TimeInterval) -> String {
//        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%.2d:%.2d", minutes, seconds)
    }
    
    func didUpdateUI(inputMinutes: String) {
        
        // probably if statement will not be needed as pomodoro timer mnimum time will be something aroung 10 min
        
        if inputMinutes.count < 2 {
            timerLabel.text =  "0\(inputMinutes):00"
        } else {
            timerLabel.text =  "\(inputMinutes):00"
        }
        
    // probably something is wrong below
        secondsRemaining = Int(inputMinutes)! * 60
        
        timer.invalidate()
        startStop.text = "START"
        
    }
    
    func setupStackView() {
        
        let maskToBound = 28.0
        
        let pomodoroLabel: UILabel = {
            let label = UILabel()
            label.backgroundColor = UIColor(red: 241/255, green: 112/255, blue: 112/255, alpha: 1)
            label.layer.cornerRadius = maskToBound
            label.layer.masksToBounds = true
            label.text = "pomodoro"
            label.textAlignment = .center
            label.textColor = UIColor(red: 215/255, green: 224/255, blue: 255/255, alpha: 1)
            label.font = UIFont.boldSystemFont(ofSize: 18)
            return label
        }()
        
        let shortBreakLabel: UILabel = {
            let label = UILabel()
//            label.backgroundColor = .red
            label.layer.cornerRadius = maskToBound
            label.layer.masksToBounds = true
            label.text = "short break"
            label.textAlignment = .center
            label.textColor = UIColor(red: 215/255, green: 224/255, blue: 255/255, alpha: 1)
            label.font = UIFont.boldSystemFont(ofSize: 18)
            return label
            
        }()
        
        let longBreakLabel: UILabel = {
            let label = UILabel()
//            label.backgroundColor = .blue
            label.layer.cornerRadius = maskToBound
            label.layer.masksToBounds = true
            label.text = "long break"
            label.textAlignment = .center
            label.textColor = UIColor(red: 215/255, green: 224/255, blue: 255/255, alpha: 1)
            label.font = UIFont.boldSystemFont(ofSize: 18)
            return label
            
        }()
        
        let stackView = UIStackView(arrangedSubviews: [pomodoroLabel, shortBreakLabel, longBreakLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.layer.cornerRadius = maskToBound
        stackView.layer.masksToBounds = true
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 6, left: 4, bottom: 6, right: 4)
        stackView.backgroundColor = #colorLiteral(red: 0.08357880265, green: 0.09788595885, blue: 0.1973884106, alpha: 1)
        
        view.addSubview(stackView)
        
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30).isActive = true
        stackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08).isActive = true
        
    }
    func setupLayout() {
        
        view.addSubview(timerView)
        
        portrait = [
        timerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        timerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        timerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        timerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
        ]
        
        NSLayoutConstraint.activate(portrait!)
        
        landscape = [
        timerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
        timerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        timerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        timerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
        ]
        
//        NSLayoutConstraint.activate(landscape!)
        
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
    }
}


