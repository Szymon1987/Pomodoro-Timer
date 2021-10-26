//
//  ColorView.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 21/10/2021.
//

import UIKit

class ColorView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let colorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "COLOR"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let bottomDividerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    let centerColorLabel: CircleLabel = {
        let label = CircleLabel()
        return label
    }()
    
    let leftColorLabel: CircleLabel = {
        let label = CircleLabel()
        return label
    }()
    
    let rightColorLabel: CircleLabel = {
        let label = CircleLabel()
        return label
    }()
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        
        
        [colorLabel,bottomDividerView, centerColorLabel, leftColorLabel, rightColorLabel].forEach{addSubview($0)}

        colorLabel.anchor(top: topAnchor, bottom: nil, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 15, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 40))
   
        bottomDividerView.anchor(top: topAnchor, bottom: nil, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: -20), size: .init(width: 0, height: 1))
      

        centerColorLabel.anchor(top: nil, bottom: nil, leading: nil, trailing: nil, size: .init(width: 40, height: 40))
        
        centerColorLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        centerColorLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        leftColorLabel.anchor(top: nil, bottom: nil, leading: nil, trailing: centerColorLabel.leadingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: -10), size: .init(width: 40, height: 40))
        
        leftColorLabel.centerYAnchor.constraint(equalTo:centerColorLabel.centerYAnchor).isActive = true
      
        rightColorLabel.anchor(top: nil, bottom: nil, leading: centerColorLabel.trailingAnchor, trailing: nil, padding: .init(top: 0, left: 10, bottom: 0, right: 0), size: .init(width: 40, height: 40))
        
        rightColorLabel.centerYAnchor.constraint(equalTo: centerColorLabel.centerYAnchor).isActive = true
   
      
    
}
}
