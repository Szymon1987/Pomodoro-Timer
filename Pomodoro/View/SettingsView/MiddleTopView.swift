//
//  PickerView.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 21/03/2022.
//

import UIKit

class MiddleTopView: UIView {
    
    private let titleLabel: ReusableLabel
    private let pomodoroButton: ReusableButton
    private let shortBreakButton: ReusableButton
    private let longBreakButton: ReusableButton
    var pickerView = UIPickerView()
    private let dividerView = DividerView()
    
    override init(frame: CGRect) {
        titleLabel = ReusableLabel(text: "TIME (MINUTES)", fontSize: 20)
        pomodoroButton = ReusableButton(title: "pomodoro", fontSize: 16, backgroundColor: .backgroundGray)
        shortBreakButton = ReusableButton(title: "short break", fontSize: 16)
        longBreakButton = ReusableButton(title: "long break", fontSize: 16)
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, bottom: nil, leading: leadingAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0))
       
        addSubview(shortBreakButton)
        shortBreakButton.anchor(top: nil, bottom: nil, leading: leadingAnchor, trailing: nil, padding: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0))
        shortBreakButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 20).isActive = true
        shortBreakButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4).isActive = true
        shortBreakButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15).isActive = true
        
        addSubview(pomodoroButton)
        pomodoroButton.anchor(top: nil, bottom: shortBreakButton.topAnchor, leading: leadingAnchor, trailing: shortBreakButton.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 15, bottom: -10, right: 0))
        pomodoroButton.heightAnchor.constraint(equalTo: shortBreakButton.heightAnchor).isActive = true
        
        addSubview(longBreakButton)
        longBreakButton.anchor(top: shortBreakButton.bottomAnchor, bottom: nil, leading: leadingAnchor, trailing: shortBreakButton.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 15, bottom: 0, right: 0))
        longBreakButton.heightAnchor.constraint(equalTo: shortBreakButton.heightAnchor).isActive = true
                
        addSubview(dividerView)
        dividerView.anchor(top: nil, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: -20), size: .init(width: 0, height: 1))
        
        addSubview(pickerView)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.topAnchor.constraint(equalTo: pomodoroButton.topAnchor).isActive = true
        pickerView.bottomAnchor.constraint(equalTo: longBreakButton.bottomAnchor).isActive = true
        pickerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        pickerView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.45).isActive = true
        
        [shortBreakButton, pomodoroButton, longBreakButton].forEach{$0.layer.cornerRadius = 8}
    }
    
    private func configurePickerView() {
        
    }
    
}
