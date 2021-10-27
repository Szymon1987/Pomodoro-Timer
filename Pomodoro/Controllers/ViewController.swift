//
//  ViewController.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 15/10/2021.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var shapeLayer = CAShapeLayer()
    
    var secondsRemaining : Int = 63
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
        label.text = "00:00"
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
    
    let settingsLauncher: SettingsLauncher = {
        let st = SettingsLauncher()
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
    
    
    // This method id needed to call setupTimierAnimation() only once after view is loaded and we can set up the size of the circle based on the UIView size. In viewDidLoad() this function doesn't work as the seize of the view is unknown at that time
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupTimerShape()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

       
    }
    
    func setupTimerShape() {
        
        let radius = timerView.frame.height / 2
//        let radius = myView.bounds.height / 2
        
        let center = CGPoint(x: timerView.layer.bounds.midX, y: timerView.layer.bounds.midY)
        //        let radius = myView.frame.width / 3
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = .round
        
        shapeLayer.strokeEnd = 0
        
        
        timerView.layer.addSublayer(shapeLayer)

    }

    
    fileprivate func animateCircle() {
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.toValue = 1
        
        basicAnimation.duration = 2
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(basicAnimation, forKey: "animation")
    }
    
    @objc func startStopTapped() {
        
        animateCircle()
        
        if isCounting {
            isCounting = false
            timer.invalidate()
            startStop.text = "START"
            
        } else {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
            isCounting = true
            startStop.text = "STOP"
            
        }
    }
    
    @objc func timerCounter() {
        
        if secondsRemaining > 0 {
            secondsRemaining -= 1
        } else {
            timer.invalidate()
            secondsRemaining = 20
        }
        timerLabel.text = timeString(time: TimeInterval(secondsRemaining))
        
    }
    
    func timeString(time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%.2d:%.2d:%.2d", hours, minutes, seconds)
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


