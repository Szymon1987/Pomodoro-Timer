//
//  ReusableView.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 12/05/2022.
//

import UIKit

class ReusableView: UIView {
    
    var titleLabel: ReusableLabel
    var middleButton: ReusableButton
    var leftButton: ReusableButton
    var rightButton: ReusableButton
    
    init(titleLabel: ReusableLabel, middleButton: ReusableButton, leftButton: ReusableButton, rightButton: ReusableButton) {
        self.titleLabel = titleLabel
        self.middleButton = middleButton
        self.leftButton = leftButton
        self.rightButton = rightButton
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
