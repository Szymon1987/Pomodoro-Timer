//
//  ReausableLabel.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 18/03/2022.
//

import UIKit

enum FontStyle {
    case bold
    case normal
    case thin
    case italic
}

class ReusableLabel: UILabel {
    
    init(text: String = "", fontSize: CGFloat = 18, fontStyle: FontStyle = .normal, textColor: UIColor = .black, textAlignment: NSTextAlignment = .center, isMultipleLine: Bool = true) {
        super.init(frame: .zero)
        setupLabel(text: text, fontSize: fontSize, fontStyle: fontStyle, textColor: textColor, textAlignment: textAlignment, isMultipleLine: isMultipleLine)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLabel(text: String, fontSize: CGFloat, fontStyle: FontStyle, textColor: UIColor, textAlignment: NSTextAlignment, isMultipleLine: Bool) {
        
        switch fontStyle {
            case .bold:
                font = UIFontMetrics(forTextStyle: UIFont.TextStyle.body).scaledFont(for: UIFont(name: "Helvetica-Bold", size: fontSize)!)
            case .normal:
                font = UIFontMetrics(forTextStyle: UIFont.TextStyle.body).scaledFont(for: UIFont(name: "Helvetica", size: fontSize)!)
            case .thin:
                font = UIFontMetrics(forTextStyle: UIFont.TextStyle.body).scaledFont(for: UIFont(name: "Helvetica-Light", size: fontSize)!)
            case .italic:
                font = UIFontMetrics(forTextStyle: UIFont.TextStyle.body).scaledFont(for: UIFont(name: "Helvetica-Oblique", size: fontSize)!)
            }
        
        self.text = text
        self.textColor = textColor
        numberOfLines = isMultipleLine ? 0 : 1
        self.textAlignment = textAlignment
        translatesAutoresizingMaskIntoConstraints = false
        layer.masksToBounds = true
        
    }
    
}
