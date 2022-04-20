//
//  ReausableLabel.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 18/03/2022.
//

import UIKit

class ReusableLabel: UILabel {
    
    
    // the initializer seems to be a bit lenghty here, is it ok?
    
    init(text: String = "", fontSize: CGFloat = 18, textColor: UIColor = .black, textAlignment: NSTextAlignment = .center, isMultipleLine: Bool = true) {
        super.init(frame: .zero)
        setupLabel(text: text, fontSize: fontSize, textColor: textColor, textAlignment: textAlignment, isMultipleLine: isMultipleLine)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLabel(text: String, fontSize: CGFloat, textColor: UIColor, textAlignment: NSTextAlignment, isMultipleLine: Bool) {
        
//        font = UIFontMetrics(forTextStyle: UIFont.TextStyle.body).scaledFont(for: UIFont(name: "Helvetica", size: fontSize)!)
        
        self.font = UIFont.normalFont(size: fontSize)
        self.text = text
        self.textColor = textColor
        numberOfLines = isMultipleLine ? 0 : 1
        self.textAlignment = textAlignment
        translatesAutoresizingMaskIntoConstraints = false
        layer.masksToBounds = true
        
    }
}
