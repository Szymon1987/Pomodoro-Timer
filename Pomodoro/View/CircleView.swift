//
//  CircleView.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 02/11/2021.
//

import UIKit

class CircleView: UIView {
//    lazy var tap = UITapGestureRecognizer(target: self, action: #selector(fontIconTapped))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        isUserInteractionEnabled = true
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 22
        layer.masksToBounds = true
//        self.addGestureRecognizer(tap)
    }
//    @objc func fontIconTapped(sender: UITapGestureRecognizer) {
//      print("parent")
//    }
}
