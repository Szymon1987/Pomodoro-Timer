//
//  FontColorView.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 21/03/2022.
//

import UIKit

class FontColorView: UIView {
    
    let titleLabel: ReusableLabel
    let roundedButton: ReusableButton
    
    
    override init(frame: CGRect) {
        titleLabel = ReusableLabel()
        roundedButton = ReusableButton(imageName: nil)
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
}
