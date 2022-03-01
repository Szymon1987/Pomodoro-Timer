//
//  CircleLabel.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 23/10/2021.
//

import UIKit

class CircleFontView: CircleView {
    
//    lazy var tap = UITapGestureRecognizer(target: self, action: #selector(fontViewTapped(_:)))
    let label = UILabel()
//    var fontName: String?
    
    override func setup() {
        super.setup()
        backgroundColor = #colorLiteral(red: 0.9333208203, green: 0.9437040687, blue: 0.9826990962, alpha: 1)
        label.text = "Aa"
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.textAlignment = .center
//        addGestureRecognizer(tap)
    }
    
//    @objc func fontViewTapped(_ sender: UITapGestureRecognizer) {
//        switch sender.view?.tag {
//        case 0:
//            fontName = "MalayalamSangamMN"
//        case 1:
//            fontName = "ArialRoundedMTBold"
//        case 2:
//            fontName = "ChalkboardSE-Bold"
//        default:
//            print("Error switching fonts")
//        }
//    }
    
}
