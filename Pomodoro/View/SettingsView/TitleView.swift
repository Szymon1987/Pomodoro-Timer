//
//  TopContainerView.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 21/03/2022.
//

import UIKit

class TitleView: UIView {
    
    private let settingsLabel: ReusableLabel
    private let dividerView = DividerView()

    override init(frame: CGRect) {
        settingsLabel = ReusableLabel(text: "Settings", fontSize: 26, fontStyle: .bold, textColor: .black, textAlignment: .left, isMultipleLine: false)
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(settingsLabel)
        settingsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25).isActive = true
        settingsLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
        settingsLabel.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
       
        addSubview(dividerView)
        dividerView.anchor(top: nil, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, size: .init(width: 0, height: 1))
    }
}
