//
//  CircleColorView.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 01/11/2021.
//

import UIKit


class CircleColorView: CircleView {
            
    lazy var checkMarkView: UIImageView = {
        let image = UIImage(systemName: "checkmark")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        imageView.isHidden = true
        return imageView
    }()

    override func setup() {
        super.setup()
        addSubview(checkMarkView)
        checkMarkView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        checkMarkView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
}
