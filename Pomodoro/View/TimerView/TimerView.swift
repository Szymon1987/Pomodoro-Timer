//
//  TimerView.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 18/03/2022.
//

import UIKit

// this view class is basically the background view for the ClockView class with

class TimerView: UIView {

    private let clockView = ClockView()
    private let roundedGradientView = UIView()

    lazy var roundedGradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.colors = [UIColor.darkPurple.cgColor, UIColor.backgroundPurpleLight.cgColor]
        gradient.locations = [0.2, 1]
        return gradient
    }()
    
    init() {
        super.init(frame: .zero)
        setupTimerView()
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

        addSubview(clockView)
        clockView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        clockView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        clockView.heightAnchor.constraint(equalTo: heightAnchor, constant: -35).isActive = true
        clockView.widthAnchor.constraint(equalTo: heightAnchor, constant: -35).isActive = true
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
        roundedGradient.frame = bounds
    }
}
