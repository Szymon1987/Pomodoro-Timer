//
//  CircleLabel.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 23/10/2021.
//

import UIKit

class CircleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        textAlignment = .center
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 22
        layer.masksToBounds = true
        backgroundColor = #colorLiteral(red: 0.9421771169, green: 0.9406086802, blue: 0.9791585803, alpha: 1)
        
    }
    
}
