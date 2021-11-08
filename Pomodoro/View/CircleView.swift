//
//  CircleView.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 02/11/2021.
//

import UIKit

class CircleView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        isUserInteractionEnabled = true
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 22
        layer.masksToBounds = true
    }
    
    func backgroundColor(bakkldjckds: UIColor) {
        backgroundColor = bakkldjckds
    }
}
