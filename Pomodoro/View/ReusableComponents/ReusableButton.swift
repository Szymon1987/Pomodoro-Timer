//
//  ReusableButton.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 18/03/2022.
//

import UIKit

class ReusableButton: UIButton {
    
    init(title: String = "", fontSize: CGFloat = 22, imageName: String?) {
        super.init(frame: .zero)
        setupButton(title: title, fontSize: fontSize, imageName: imageName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton(title: String, fontSize: CGFloat, imageName: String?) {
        setTitle(title, for: .normal)
        titleLabel?.textColor = .white
        titleLabel?.font = UIFontMetrics(forTextStyle: UIFont.TextStyle.body).scaledFont(for: UIFont(name: "Helvetica-Bold", size: fontSize)!)
        translatesAutoresizingMaskIntoConstraints = false
        if let imageName = imageName {
            let image = UIImage(named: imageName)!.withTintColor(.gray, renderingMode: .alwaysOriginal)
            imageView?.image = image
            setImage(image, for: .normal)
        }
    }
    
}
