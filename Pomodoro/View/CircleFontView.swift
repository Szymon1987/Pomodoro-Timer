//
//  CircleLabel.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 23/10/2021.
//

import UIKit

class CircleFontView: CircleView {

    let label = UILabel()
    
    override func setup() {
        super.setup()
        backgroundColor = ColorManager.backgroundGray
        label.text = "Aa"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.textAlignment = .center
    }

}
