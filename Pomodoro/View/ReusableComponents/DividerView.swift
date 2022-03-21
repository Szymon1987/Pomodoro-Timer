//
//  DividerView.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 21/03/2022.
//

import UIKit

class DividerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .lightGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
