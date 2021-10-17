//
//  ViewController.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 15/10/2021.
//

import UIKit

class ViewController: UIViewController {
    
//    let shapeLayer = CAShapeLayer()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .blue
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
        label.font = UIFont.boldSystemFont(ofSize: 60)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.backgroundColor = .green
        return label
    }()
    
    lazy var pauseLabel: UILabel = {
        let label = UILabel()
        label.text = "PAUSE"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.isUserInteractionEnabled = true
        //label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped)))
        label.backgroundColor = .cyan
        return label
    }()
    
    let myView: CustomCircleView = {
        let view = CustomCircleView()
        view.backgroundColor = .cyan
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.1163143292, green: 0.128652513, blue: 0.2517923713, alpha: 1)
        setupLayout()
        setupStackView()
        
       // uncomment later
       // setupTimerAnimation()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLayout()
    }
    
    //  CUSTOM CLASS FOR TIMER

//    let circleTimer: CircleTimer = {
//        let ct = CircleTimer()
//        ct.backgroundColor = .red
//        ct.translatesAutoresizingMaskIntoConstraints = false
//        return ct
//    }()
    
//    func setupTimerAnimation() {
//        let center = view.center
//        let circularPath = UIBezierPath(arcCenter: center, radius: view.frame.size.width / 3, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
//        shapeLayer.path = circularPath.cgPath
//
//        shapeLayer.strokeColor = UIColor.red.cgColor
//        shapeLayer.lineWidth = 10
//        shapeLayer.fillColor = UIColor.clear.cgColor
//        shapeLayer.lineCap = .round
//
//        shapeLayer.strokeEnd = 0
//
//        view.layer.addSublayer(shapeLayer)
//    }
//
//    fileprivate func animateCircle() {
//        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
//
//        basicAnimation.toValue = 1
//
//        basicAnimation.duration = 2
//
//        basicAnimation.fillMode = .forwards
//        basicAnimation.isRemovedOnCompletion = false
//
//        shapeLayer.add(basicAnimation, forKey: "animation")
//    }
//
//    @objc func tapped() {
//
//        animateCircle()
//    }
    
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
        stackView.backgroundColor = .purple
        
        view.addSubview(stackView)
        
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30).isActive = true
        stackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07).isActive = true
        
    }
    
    func setupLayout() {
        
        
        view.addSubview(timerLabel)
        timerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
        
        view.addSubview(pauseLabel)
        pauseLabel.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 30).isActive = true
        pauseLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        pauseLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        pauseLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//
        
        
        
        view.addSubview(myView)
        
        myView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        myView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        myView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        myView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
        
        
        
        
//        view.addSubview(circleTimer)
//
//        circleTimer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        circleTimer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        circleTimer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        circleTimer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25).isActive = true

        
        
    }

}


