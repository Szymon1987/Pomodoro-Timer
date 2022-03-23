//
//  FontCircleViewBaseClass.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 23/03/2022.
//

import UIKit

class FontColorViewBaseClass: UIView {
    
    var titleLabel: ReusableLabel
    var leftRoundedButton: ReusableButton
    var middleRoundedButton: ReusableButton
    var rightRoundedButton: ReusableButton
    private let roundedButtonTitle = "Aa"
    
    override init(frame: CGRect) {
        titleLabel = ReusableLabel(text: "FONT")
        leftRoundedButton = ReusableButton(title: roundedButtonTitle, textColor: .white, backgroundColor: .black)
        middleRoundedButton = ReusableButton(title: roundedButtonTitle, backgroundColor: .backgroundGray)
        rightRoundedButton = ReusableButton(title: roundedButtonTitle, backgroundColor: .backgroundGray)
        super.init(frame: frame)
        setupViews()

    }
    
    init(title: String, color: UIColor) {
        titleLabel = ReusableLabel()
        leftRoundedButton = ReusableButton()
        middleRoundedButton = ReusableButton()
        rightRoundedButton = ReusableButton()
        super.init(frame: .zero)
        setupViews()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        
        [titleLabel, middleRoundedButton, rightRoundedButton, leftRoundedButton].forEach{addSubview($0)}
        
        titleLabel.anchor(top: topAnchor, bottom: nil, leading: leadingAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0))
        
        middleRoundedButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        middleRoundedButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 10).isActive = true
        middleRoundedButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        middleRoundedButton.widthAnchor.constraint(equalToConstant: 48).isActive = true
        
        leftRoundedButton.centerYAnchor.constraint(equalTo: middleRoundedButton.centerYAnchor).isActive = true
        leftRoundedButton.heightAnchor.constraint(equalTo: middleRoundedButton.heightAnchor).isActive = true
        leftRoundedButton.widthAnchor.constraint(equalTo: middleRoundedButton.widthAnchor).isActive = true
        leftRoundedButton.trailingAnchor.constraint(equalTo: middleRoundedButton.leadingAnchor, constant: -20).isActive = true
        
        rightRoundedButton.centerYAnchor.constraint(equalTo: middleRoundedButton.centerYAnchor).isActive = true
        rightRoundedButton.heightAnchor.constraint(equalTo: middleRoundedButton.heightAnchor).isActive = true
        rightRoundedButton.widthAnchor.constraint(equalTo: middleRoundedButton.widthAnchor).isActive = true
        rightRoundedButton.leadingAnchor.constraint(equalTo: middleRoundedButton.trailingAnchor, constant: 20).isActive = true
        [titleLabel, middleRoundedButton, rightRoundedButton, leftRoundedButton].forEach{$0.layer.cornerRadius = 24}

    }
    
}

