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
        label.text = "17:59"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 50)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        //label.backgroundColor = .red
        return label
    }()
    
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
    
    let myView: UIView = {
        let view = UIView()
//        view.backgroundColor = #colorLiteral(red: 0.139921248, green: 0.1541073918, blue: 0.3137726188, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
                view.backgroundColor = .cyan
        return view
    }()
    
    let gearIconView: UIImageView = {
        let image = UIImage(systemName: "gearshape.fill")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.139921248, green: 0.1541073918, blue: 0.3137726188, alpha: 1)
        setupLayout()
        setupStackView()
        //setupTimerAnimation()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        isPortrait = UIDevice.current.orientation.isPortrait
        if isPortrait {
            NSLayoutConstraint.deactivate(landscape!)
            NSLayoutConstraint.activate(portrait!)
            print("portrait")
        } else {
            NSLayoutConstraint.deactivate(portrait!)
            NSLayoutConstraint.activate(landscape!)
            print("landscape")
        }
        
        //setupTimerAnimation()
        
    }
    
    func setupTimerAnimation() {
        let frameWidth = myView.frame.width
        let frameHeight = myView.frame.height
        let radius = (frameWidth + frameHeight) / 5
//        let radius = myView.frame.height
        
        let center = CGPoint(x: myView.layer.bounds.midX, y: myView.layer.bounds.midY)
        //        let radius = myView.frame.width / 3
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = .round
        
        shapeLayer.strokeEnd = 0
        
        myView.layer.addSublayer(shapeLayer)
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
            label.backgroundColor = .green
            label.layer.cornerRadius = maskToBound
            label.layer.masksToBounds = true
            label.text = "pomodoro"
            label.textAlignment = .center
            label.textColor = .white
            label.font = UIFont.boldSystemFont(ofSize: 18)
            return label
        }()
        
        let shortBreakLabel: UILabel = {
            let label = UILabel()
            label.backgroundColor = .red
            label.layer.cornerRadius = maskToBound
            label.layer.masksToBounds = true
            label.text = "short break"
            label.textAlignment = .center
            label.textColor = .white
            label.font = UIFont.boldSystemFont(ofSize: 18)
            return label
            
        }()
        
        let longBreakLabel: UILabel = {
            let label = UILabel()
            label.backgroundColor = .blue
            label.layer.cornerRadius = maskToBound
            label.layer.masksToBounds = true
            label.text = "long break"
            label.textAlignment = .center
            label.textColor = .white
            label.font = UIFont.boldSystemFont(ofSize: 18)
            return label
            
        }()
        
        let stackView = UIStackView(arrangedSubviews: [pomodoroLabel, shortBreakLabel, longBreakLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.layer.cornerRadius = maskToBound
        stackView.layer.masksToBounds = true
        stackView.backgroundColor = #colorLiteral(red: 0.08357880265, green: 0.09788595885, blue: 0.1973884106, alpha: 1)
        
        view.addSubview(stackView)
        
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30).isActive = true
        stackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07).isActive = true
        
    }
    
    func setupLayout() {
        
        view.addSubview(myView)
        
        portrait = [
        myView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        myView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        myView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        myView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
        ]
        
        landscape = [
        myView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
        myView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        myView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
        ]
        
        view.addSubview(titleLabel)
        
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
        
        myView.addSubview(timerLabel)
        
        timerLabel.centerYAnchor.constraint(equalTo: myView.centerYAnchor).isActive = true
        timerLabel.centerXAnchor.constraint(equalTo: myView.centerXAnchor).isActive = true
        
        myView.addSubview(startStop)
        
        startStop.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 20).isActive = true
        startStop.centerXAnchor.constraint(equalTo: myView.centerXAnchor).isActive = true
        
        view.addSubview(gearIconView)
        
        gearIconView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        gearIconView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        gearIconView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        gearIconView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        
        
        
        
    }
    
    
}


