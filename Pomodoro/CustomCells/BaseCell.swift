//
//  BaseCell.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 09/05/2022.
//

import UIKit

protocol BaseCellDelegate: AnyObject {
    func updateModel()
}

class BaseCell: UITableViewCell {
    
    weak var baseCellDelegate: BaseCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
