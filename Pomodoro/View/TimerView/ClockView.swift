//
//  ClockView.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 21/03/2022.
//

import UIKit

class ClockView: UIView {
    
    let clockLabel: ReusableLabel
    let startStopLabel: ReusableLabel
    
    init() {
        clockLabel = ReusableLabel(text: "00:06", fontSize: 54, textColor: .white)
        startStopLabel = ReusableLabel(text: "START", fontSize: 22, textColor: .white)
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.darkPurple
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(clockLabel)
        clockLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10).isActive = true
        clockLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(startStopLabel)
        startStopLabel.topAnchor.constraint(equalTo: clockLabel.bottomAnchor, constant: 17).isActive = true
        startStopLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        // sets the spacing between the chatacters in the label
        startStopLabel.setTextSpacingBy(value: 10)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.frame.height / 2
    }
    
}
