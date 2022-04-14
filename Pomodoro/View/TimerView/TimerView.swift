//
//  TimerView.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 18/03/2022.
//

import UIKit

class TimerView: UIView {

    var roundedGradientView = UIView()

    lazy var roundedGradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.colors = [UIColor.darkPurple.cgColor, UIColor.backgroundPurpleLight.cgColor]
        gradient.locations = [0.2, 1]
        return gradient
    }()
    
    var clockBackgroundView = ClockView()
    var CircleShapeLayer = CAShapeLayer()
   

    init() {
        super.init(frame: .zero)
        setupTimerView()
        setupShapeLayer()
//        setupClockBackgroundView()
        setupRoundedGradientView()
        backgroundColor = UIColor.darkPurple
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Setup
    
    private func setupTimerView() {
        
        backgroundColor = UIColor.backgroundPurple
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.shadowColor = UIColor.backgroundPurpleLight.cgColor
        layer.rasterizationScale = UIScreen.main.scale
        layer.shadowRadius = 40
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -25, height: -40)
        
        
        addSubview(roundedGradientView)
        roundedGradientView.anchorSize(to: self)
        
        roundedGradientView.layer.addSublayer(roundedGradient)

        addSubview(clockBackgroundView)
        clockBackgroundView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        clockBackgroundView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        clockBackgroundView.heightAnchor.constraint(equalTo: heightAnchor, constant: -35).isActive = true
        clockBackgroundView.widthAnchor.constraint(equalTo: heightAnchor, constant: -35).isActive = true
        
        
    }
    
    private func setupShapeLayer() {
        
        CircleShapeLayer.strokeColor = UIColor.pomodoroOrange.cgColor
        CircleShapeLayer.lineWidth = 10
        CircleShapeLayer.lineCap = .round
        CircleShapeLayer.fillColor = UIColor.clear.cgColor
//        shapeLayer.strokeEnd = 0
         layer.addSublayer(CircleShapeLayer)

    }
    
    private func setupRoundedGradientView() {
        roundedGradientView.backgroundColor = UIColor.green
        roundedGradientView.translatesAutoresizingMaskIntoConstraints = false
        roundedGradientView.clipsToBounds = true
    
        }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = self.frame.height / 2
        roundedGradientView.layer.cornerRadius = self.frame.height / 2
        
        
        let center = CGPoint(x: layer.bounds.midX, y: layer.bounds.midY)
        CircleShapeLayer.position = center
        
        roundedGradient.frame = bounds
        
        let radius = (clockBackgroundView.frame.height - 35) / 2
        let circularPath = UIBezierPath(arcCenter: .zero, radius: radius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        CircleShapeLayer.path = circularPath.cgPath
        

        
    }
    
}
