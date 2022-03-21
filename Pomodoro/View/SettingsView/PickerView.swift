//
//  PickerView.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 21/03/2022.
//

import UIKit

class PickerView: UIView {
    
    private let dividerView = DividerView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .green
        
        addSubview(dividerView)
//        dividerView.anchor(top: nil, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, size: .init(width: 0, height: 1))
        dividerView.anchor(top: nil, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: -20), size: .init(width: 0, height: 1))
        dividerView.backgroundColor = .red
        
    }
    
}
