//
//  CircleAnimation.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 14/04/2022.
//

import QuartzCore

//import UIKit
//
//class CircleAnimation: UIView {
//    
//    func startAnimation() {
//        let circleAnimation = CABasicAnimation(keyPath: "strokeEnd")
//        circleAnimation.fromValue = 1
//        circleAnimation.toValue = 0
//        circleAnimation.duration = CFTimeInterval(totalSeconds)
//        circleAnimation.isRemovedOnCompletion = false
//        shapeLayer.add(circleAnimation, forKey: "animation")
//    }
//
//    private func pauseAnimation() {
//        let pausedTime: CFTimeInterval = shapeLayer.convertTime(CACurrentMediaTime(), from: nil)
//        shapeLayer.speed = 0.0
//        shapeLayer.timeOffset = pausedTime
//    }
//
//    private func resumeAnimation() {
//        let pausedTime = shapeLayer.timeOffset
//        shapeLayer.speed = 1.0
//        shapeLayer.timeOffset = 0.0
//        shapeLayer.beginTime = 0.0
//        shapeLayer.strokeEnd = 1.0
//        let timeSincePause = shapeLayer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
//        shapeLayer.beginTime = timeSincePause
//    }
//}
//    
