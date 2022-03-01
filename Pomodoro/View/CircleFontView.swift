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
//    var fontString: String?
    
    override func setup() {
        super.setup()
        backgroundColor = ColorManager.fontViewBackgroundColor
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
