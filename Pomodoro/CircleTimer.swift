//
//  CircleTimer.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 16/10/2021.
//

import UIKit

class CircleTimer: UIView {

//    override public class var layerClass: AnyClass {
//        return CAShapeLayer.self
//    }
        
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let cLayer = CAShapeLayer()
        
        cLayer.frame = bounds
        
        let radius = min(bounds.width, bounds.height) / 2.0
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi , clockwise: true)
        cLayer.path = path.cgPath
        layer.mask = cLayer
    }
    
}
