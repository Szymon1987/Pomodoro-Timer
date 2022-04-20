//
//  ColorView.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 23/03/2022.
//

import UIKit


class ColorView: UIView {
    
    private let titleLabel: ReusableLabel
    let redRoundedButton: ReusableButton
    let blueRoundedButton: ReusableButton
    let purpleRoundedButton: ReusableButton
    
    // same as "selectedFont" in the FontView class
    var selectedColor: UIColor?
    
    private let checkmarkImage = UIImage(systemName: "checkmark")?.withTintColor(.black, renderingMode: .alwaysOriginal)

    override init(frame: CGRect) {
        titleLabel = ReusableLabel(text: "COLOR")
        redRoundedButton = ReusableButton(systemImageName: "checkmark", backgroundColor: .pomodoroOrange)
        blueRoundedButton = ReusableButton(backgroundColor: .pomodoroBlue)
        purpleRoundedButton = ReusableButton(backgroundColor: .pomodoroPurple)
        super.init(frame: frame)
        setupViews()
        addTargetForButtons()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //  what is the better way to add gesture recognizers to avoid repetition?
    private func addTargetForButtons() {
        let buttons = [redRoundedButton, blueRoundedButton, purpleRoundedButton]
        for button in buttons {
            button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        }
    }
    // is there a better way to moving the checkmark position when button is pressed?
     @objc private func tapped(_ sender: ReusableButton) {
        let buttons = [redRoundedButton, blueRoundedButton, purpleRoundedButton]
        buttons.forEach{$0.setImage(nil, for: .normal)}
        sender.setImage(checkmarkImage, for: .normal)
        selectedColor = sender.backgroundColor
    }
    
    // the setupView function is identical with FontView setupView function, how to fix it?
    
    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        
        [titleLabel, redRoundedButton, blueRoundedButton, purpleRoundedButton].forEach{addSubview($0)}
        
        titleLabel.anchor(top: topAnchor, bottom: nil, leading: leadingAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0))
        
        blueRoundedButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        blueRoundedButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 10).isActive = true
        blueRoundedButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        blueRoundedButton.widthAnchor.constraint(equalToConstant: 48).isActive = true
        
        redRoundedButton.centerYAnchor.constraint(equalTo: blueRoundedButton.centerYAnchor).isActive = true
        redRoundedButton.heightAnchor.constraint(equalTo: blueRoundedButton.heightAnchor).isActive = true
        redRoundedButton.widthAnchor.constraint(equalTo: blueRoundedButton.widthAnchor).isActive = true
        redRoundedButton.trailingAnchor.constraint(equalTo: blueRoundedButton.leadingAnchor, constant: -20).isActive = true
        
        purpleRoundedButton.centerYAnchor.constraint(equalTo: blueRoundedButton.centerYAnchor).isActive = true
        purpleRoundedButton.heightAnchor.constraint(equalTo: blueRoundedButton.heightAnchor).isActive = true
        purpleRoundedButton.widthAnchor.constraint(equalTo: blueRoundedButton.widthAnchor).isActive = true
        purpleRoundedButton.leadingAnchor.constraint(equalTo: blueRoundedButton.trailingAnchor, constant: 20).isActive = true
        [titleLabel, blueRoundedButton, purpleRoundedButton, redRoundedButton].forEach{$0.layer.cornerRadius = 24}
    }
}
