//
//  NewSettingsView.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 21/03/2022.
//

import UIKit

class NewSettingsView: UIView {
    
    weak var mainView: MainView?
    
    let titleView = TitleView()
    let pickerView = PickerView()
    let fontView = FontColorView()
    let colorView = FontColorView()
    let dividerView = DividerView()
    
    
    /// fix it later
    let applyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Apply", for: .normal)
        button.backgroundColor = UIColor.pomodoroOrange
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 26
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(applyButtonPressed), for: .touchUpInside)
        return button
    }()
    
    @objc func applyButtonPressed() {
        print("Pressed")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        layer.cornerRadius = 20
//        clipsToBounds = true
        
        addSubview(titleView)
        titleView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        titleView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.12).isActive = true
        
        addSubview(pickerView)
        pickerView.topAnchor.constraint(equalTo: titleView.bottomAnchor).isActive = true
        pickerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        pickerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        pickerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.38).isActive = true
        
        addSubview(fontView)
        fontView.topAnchor.constraint(equalTo: pickerView.bottomAnchor).isActive = true
        fontView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        fontView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        fontView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25).isActive = true
        fontView.backgroundColor = .orange
        
        fontView.addSubview(dividerView)
        dividerView.anchor(top: nil, bottom: fontView.bottomAnchor, leading: fontView.leadingAnchor, trailing: fontView.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: -20), size: .init(width: 0, height: 1))
        dividerView.backgroundColor = .red
        
        addSubview(colorView)
        colorView.topAnchor.constraint(equalTo: fontView.bottomAnchor).isActive = true
        colorView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        colorView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        colorView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
//        colorView.backgroundColor = .systemGray
        
        colorView.addSubview(applyButton)
        applyButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.40).isActive = true
        applyButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        applyButton.topAnchor.constraint(equalTo: bottomAnchor, constant: -30).isActive = true
        applyButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
}
