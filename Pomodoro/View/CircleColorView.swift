//
//  CircleColorView.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 01/11/2021.
//

import UIKit


class CircleColorView: CircleView {
    
//    var isChecked = false
        
    lazy var checkMarkView: UIImageView = {
        let image = UIImage(systemName: "checkmark")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        imageView.isHidden = true
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(colorIconTapped)))
        return imageView
    }()
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setup()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func setup() {
        super.setup()
        addSubview(checkMarkView)
        checkMarkView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        checkMarkView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    @objc func colorIconTapped() {
        checkMarkView.isHidden = !checkMarkView.isHidden
    }
}
