//
//  FontCell.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 09/05/2022.
//

import UIKit

class FontCell: UITableViewCell {
    
    var titleLabel: ReusableLabel
    var middleButton: ReusableButton
    var leftButton: ReusableButton
    var rightButton: ReusableButton
    private let roundedButtonTitle = "Aa"
    
    var selectedFont: UIFont?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        titleLabel = ReusableLabel(text: "FONT")
        leftButton = ReusableButton(title: roundedButtonTitle, textColor: .white, backgroundColor: .black)
        middleButton = ReusableButton(title: roundedButtonTitle, fontType: .italicFont(size: 16) , backgroundColor: .backgroundGray)
        rightButton = ReusableButton(title: roundedButtonTitle, fontType: .boldFont(size: 16), backgroundColor: .backgroundGray)
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

    @objc private func tapped(_ sender: ReusableButton) {
        let buttons = [middleButton, leftButton, rightButton]
        for button in buttons {
            button.backgroundColor = .backgroundGray
            button.setTitleColor(.black, for: .normal)
        }
        sender.backgroundColor = .black
        sender.setTitleColor(.white, for: .normal)
        selectedFont = sender.titleLabel?.font
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
