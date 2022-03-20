//
//  TimerView.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 18/03/2022.
//

import UIKit


class TimerView: UIView {
    
    let clockLabel: ReusableLabel
    let startStopLabel: ReusableLabel
    
    var shapeLayer = CAShapeLayer()
  
    
    init() {
        clockLabel = ReusableLabel(text: "00:06", fontSize: 54)
        startStopLabel = ReusableLabel(text: "start", fontSize: 22)
        super.init(frame: .zero)
        setupTimerView()
        setupShapeLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTimerView() {
        backgroundColor = .green.withAlphaComponent(0.3)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupShapeLayer() {
        
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 100, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.pomodoroOrange.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.lineCap = .round
//        shapeLayer.strokeEnd = 0
        layer.addSublayer(shapeLayer)
//        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        
//
//        shapeLayer.fillColor = UIColor.clear.cgColor
        

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let center = CGPoint(x: layer.bounds.midX, y: layer.bounds.midY)
        shapeLayer.position = center
    }
    
}
