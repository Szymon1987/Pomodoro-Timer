//
//  TopContainerView.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 21/03/2022.
//

import UIKit

class TitleView: UIView {
    
    private let settingsLabel: ReusableLabel
    private let xmarkButton: ReusableButton
    private let dividerView = DividerView()

    override init(frame: CGRect) {
        settingsLabel = ReusableLabel(text: "Settings", fontSize: 26, fontStyle: .bold, textColor: .black, textAlignment: .left, isMultipleLine: false)
        xmarkButton = ReusableButton(systemImageName: "xmark")
        super.init(frame: frame)
        configureXmarkButton()
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
        
        addSubview(xmarkButton)
        xmarkButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        xmarkButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        xmarkButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        xmarkButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        
        addSubview(dividerView)
        dividerView.anchor(top: nil, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, size: .init(width: 0, height: 1))
    }
    
    private func configureXmarkButton() {
        xmarkButton.tintColor = .systemGray
        xmarkButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
    }
    
    @objc func handleDismiss() {
        Haptics.playLightImpact()
        /// improve the function, find proper animation for dismissing the view
        let animation = CABasicAnimation()
        animation.keyPath = "transform.scale"
        animation.fromValue = 1
        animation.toValue = 0.00001
        animation.duration = 0.2
        self.layer.add(animation, forKey: "basic")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15, execute: self.removeFromSuperview)
    }
    
}
