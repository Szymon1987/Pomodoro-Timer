//
//  Extensions.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 24/10/2021.
//

import UIKit

extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor?, bottom: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: padding.bottom).isActive = true
        }
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: padding.right).isActive = true
        }
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    func anchorSize(to view: UIView) {
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
}

extension UIColor {
    
    //MARK: - UIComponents Colors
    public static let pomodoroOrange = UIColor(red: 241/255, green: 112/255, blue: 112/255, alpha: 1)
    public static let pomodoroBlue = UIColor(red: 112/255, green: 243/255, blue: 248/255, alpha: 1)
    public static let pomodoroPurple = UIColor(red: 216/255, green: 129/255, blue: 248/255, alpha: 1)
    public static let darkPurple = UIColor(red: 22/255, green: 25/255, blue: 50/255, alpha: 1)
    public static let backgroundGray = UIColor(red: 237/255, green: 241/255, blue: 251/255, alpha: 1)
    public static let lightTextColor = UIColor(red: 89/255, green: 93/255, blue: 120/255, alpha: 1)
    
    // MARK: - Background Color
    public static let backgroundPurple = UIColor(red: 30/255, green: 33/255, blue: 63/255, alpha: 1)
    
    // MARK: - Background Layer Color
    public static let backgroundPurpleLight = UIColor(red: 57/255, green: 64/255, blue: 112/255, alpha: 1)
}



extension UIFont {
    static func normalFont(size: CGFloat) -> UIFont {
        return customFontWith(familyName: "Helvetica", size: size)
    }
    static func boldFont(size: CGFloat) -> UIFont {
        return customFontWith(familyName: "ChalkboardSE-Bold", size: size)
    }
    static func italicFont(size: CGFloat) -> UIFont {
        return customFontWith(familyName: "Helvetica-Oblique", size: size)
    }
    
    static func customFontWith(familyName: String, size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: familyName, size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return customFont
    }
}

extension UILabel {
  func setTextSpacingBy(value: Double) {
    if let textString = self.text {
      let attributedString = NSMutableAttributedString(string: textString)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: value, range: NSRange(location: 0, length: attributedString.length - 1))
      attributedText = attributedString
    }
  }
}

extension UIView {
    func setRoundedCorner(withRadius radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        self.layer.isOpaque = false
    }
}
