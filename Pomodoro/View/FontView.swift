//
//  FontView.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 21/10/2021.
//

import UIKit

class FontView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sutupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let fontLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "FONT"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let centerFontLabel: CircleLabel = {
        let label = CircleLabel()
        return label
    }()
    
    let leftFontLabel: CircleLabel = {
        let label = CircleLabel()
        return label
    }()
    
    let rightFontLabel: CircleLabel = {
        let label = CircleLabel()
        return label
    }()
    
    private func sutupView() {

        translatesAutoresizingMaskIntoConstraints = false
        
        [fontLabel, centerFontLabel, leftFontLabel, rightFontLabel].forEach{addSubview($0)}
        
        fontLabel.anchor(top: topAnchor, bottom: nil, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 15, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 40))
        
        centerFontLabel.anchor(top: nil, bottom: nil, leading: nil, trailing: nil, size: .init(width: 40, height: 40))
        centerFontLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        centerFontLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 20).isActive = true

        leftFontLabel.anchor(top: nil, bottom: nil, leading: nil, trailing: centerFontLabel.leadingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: -10), size: .init(width: 40, height: 40))
        leftFontLabel.centerYAnchor.constraint(equalTo:centerFontLabel.centerYAnchor).isActive = true

        rightFontLabel.anchor(top: nil, bottom: nil, leading: centerFontLabel.trailingAnchor, trailing: nil, padding: .init(top: 0, left: 10, bottom: 0, right: 0), size: .init(width: 40, height: 40))
        rightFontLabel.centerYAnchor.constraint(equalTo: centerFontLabel.centerYAnchor).isActive = true

    }
    
    
}
