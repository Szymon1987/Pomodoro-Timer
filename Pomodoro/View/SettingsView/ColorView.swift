//
//  ColorView.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 23/03/2022.
//

import UIKit

class ColorView: FontView {
//
//    lazy var checkMarkView: UIImageView = {
//        let image = UIImage(systemName: "checkmark")
//        let imageView = UIImageView(image: image)
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.contentMode = .scaleAspectFit
//        imageView.tintColor = .black
////        imageView.isHidden = true
//        return imageView
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupViews() {
        super.setupViews()
//        middleRoundedButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    // not sure if this is the right approach, overriding existing properties from superclass
    
    func configure() {
        titleLabel.text = "COLOR"
        leftRoundedButton.setTitle("", for: .normal)
        leftRoundedButton.backgroundColor = .pomodoroOrange
        middleRoundedButton.setTitle("", for: .normal)
        middleRoundedButton.backgroundColor = .pomodoroBlue
        rightRoundedButton.setTitle("", for: .normal)
        rightRoundedButton.backgroundColor = .pomodoroPurple
        let image = UIImage(systemName: "checkmark")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        leftRoundedButton.setImage(image, for: .normal)
    }
}

