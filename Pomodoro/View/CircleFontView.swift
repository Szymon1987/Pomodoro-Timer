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
        backgroundColor = #colorLiteral(red: 0.9333208203, green: 0.9437040687, blue: 0.9826990962, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.textAlignment = .center
    }
    
}
