//
//  CustomCIrcleView.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 17/10/2021.
//

import UIKit

class CustomCircleView: UIView {
    lazy var shapeLayer = CAShapeLayer()
    
    lazy var label2: UILabel = {
        let label = UILabel()
        label.text = "17:59"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 60)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.backgroundColor = .orange
        label.isUserInteractionEnabled = true
       // label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped)))
        return label
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setup()
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        let circularPath = UIBezierPath(arcCenter: center, radius: self.frame.size.width / 3, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        layer.addSublayer(shapeLayer)
    }
    
//    func setup() {
//        print("cdcdscds")
//        let center = self.center
//        let circularPath = UIBezierPath(arcCenter: center, radius: self.frame.size.width / 3, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
//        shapeLayer.path = circularPath.cgPath
//
//        shapeLayer.strokeColor = UIColor.red.cgColor
//        shapeLayer.lineWidth = 10
//        shapeLayer.fillColor = UIColor.green.cgColor
//        shapeLayer.lineCap = .round
//
//        shapeLayer.strokeEnd = 0
//        layer.addSublayer(shapeLayer)
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
//       print("tapped")
//        animateCircle()
//    }
    
    
    func setupLayout() {
        self.addSubview(label2)
        label2.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        label2.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
}
