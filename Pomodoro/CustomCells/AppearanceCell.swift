//
//  BaseAppearanceCell.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 27/04/2022.
//

import UIKit

class AppearanceCell: UITableViewCell {
    
    var titleLabel: ReusableLabel
    var middleButton: ReusableButton
    var leftButton: ReusableButton
    var rightButton: ReusableButton
    
    static let appearanceCellId = "AppearanceCellId"
    var selectedColor: UIColor?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        titleLabel = ReusableLabel(text: "COLOR")
        leftButton = ReusableButton(systemImageName: "checkmark", backgroundColor: .pomodoroOrange)
        middleButton = ReusableButton(backgroundColor: .pomodoroBlue)
        rightButton = ReusableButton(backgroundColor: .pomodoroPurple)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        addTargetForButtons()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addTargetForButtons() {
        let buttons = [middleButton, leftButton, rightButton]
        for button in buttons {
            button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        }
    }
    
    private let checkmarkImage = UIImage(systemName: "checkmark")?.withTintColor(.black, renderingMode: .alwaysOriginal)
    // is there a better way to moving the checkmark position when button is pressed?
    @objc private func tapped(_ sender: ReusableButton) {
        let buttons = [middleButton, leftButton, rightButton]
        buttons.forEach{$0.setImage(nil, for: .normal)}
        sender.setImage(checkmarkImage, for: .normal)
        selectedColor = sender.backgroundColor!
    }
    private func setupViews() {
        
        let views = [titleLabel, middleButton, leftButton, rightButton]
        views.forEach{contentView.addSubview($0)}
        titleLabel.anchor(top: topAnchor, bottom: nil, leading: leadingAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0))
        middleButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        middleButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 10).isActive = true
        middleButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        middleButton.widthAnchor.constraint(equalToConstant: 48).isActive = true
        
        leftButton.centerYAnchor.constraint(equalTo: middleButton.centerYAnchor).isActive = true
        leftButton.heightAnchor.constraint(equalTo: middleButton.heightAnchor).isActive = true
        leftButton.widthAnchor.constraint(equalTo: middleButton.widthAnchor).isActive = true
        leftButton.trailingAnchor.constraint(equalTo: middleButton.leadingAnchor, constant: -20).isActive = true
        
        rightButton.centerYAnchor.constraint(equalTo: middleButton.centerYAnchor).isActive = true
        rightButton.heightAnchor.constraint(equalTo: middleButton.heightAnchor).isActive = true
        rightButton.widthAnchor.constraint(equalTo: middleButton.widthAnchor).isActive = true
        rightButton.leadingAnchor.constraint(equalTo: middleButton.trailingAnchor, constant: 20).isActive = true
        
        views.forEach{$0.layer.cornerRadius = 24}
        
    }
}
