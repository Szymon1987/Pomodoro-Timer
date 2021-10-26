//
//  Settings.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 20/10/2021.
//

import UIKit

class SettingsLauncher: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        showSettings()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let applyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Apply", for: .normal)
        let applyButtonColor = UIColor(red: 241/255, green: 112/255, blue: 112/255, alpha: 1)
        button.backgroundColor = applyButtonColor
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 26
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let settingsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "   Settings"
        label.font = UIFont.boldSystemFont(ofSize: 26)
        return label
    }()

    lazy var xmarkView: UIImageView = {
        let image = UIImage(systemName: "xmark")
        let imageView = UIImageView(image: image)
        imageView.tintColor = .systemGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        return imageView
    }()
    
    @objc func handleDismiss() {
        
        self.removeFromSuperview()
        
    }
    
    let timeMinutesView: TimeMinutesView = {
        let view = TimeMinutesView()
        return view
    }()
    
    let fontView: FontView = {
        let view = FontView()
        return view
    }()
    
    let colorView: ColorView = {
        let colorview = ColorView()
        return colorview
    }()
    
    
    private func showSettings() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 20
        
        [settingsLabel, xmarkView, timeMinutesView, fontView, colorView, applyButton].forEach{addSubview($0)}
        
        
        settingsLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        settingsLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        settingsLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        settingsLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15).isActive = true
        
        
    
        xmarkView.centerYAnchor.constraint(equalTo: settingsLabel.centerYAnchor).isActive = true
        xmarkView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        xmarkView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        xmarkView.trailingAnchor.constraint(equalTo: settingsLabel.trailingAnchor, constant: -20).isActive = true
        
 
        
        timeMinutesView.topAnchor.constraint(equalTo: settingsLabel.bottomAnchor).isActive = true
        timeMinutesView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        timeMinutesView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        timeMinutesView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.35).isActive = true
        


        fontView.topAnchor.constraint(equalTo: timeMinutesView.bottomAnchor).isActive = true
        fontView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        fontView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        fontView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25).isActive = true
        
    
        
        colorView.topAnchor.constraint(equalTo: fontView.bottomAnchor).isActive = true
        colorView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        colorView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        colorView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25).isActive = true
        

        
        applyButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.40).isActive = true
        applyButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        applyButton.topAnchor.constraint(equalTo: bottomAnchor, constant: -30).isActive = true
        applyButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    
}

