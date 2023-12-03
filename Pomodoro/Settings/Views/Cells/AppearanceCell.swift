import UIKit

final class AppearanceCell: UITableViewCell {
    
    var updateColorAndFont: ((UIColor?, UIFont?) -> Void)?
    
    private let titleLabel: ReusableLabel = {
        let label = ReusableLabel()
        return label
    }()
    
    private let leftButton = ReusableButton()
    private let middleButton = ReusableButton()
    private let rightButton = ReusableButton()
    
    private let roundedButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 6
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    private func handleButtonTap(color: UIColor, selectedButton: ReusableButton?, image: UIImage?, font: UIFont?) {
        roundedButtonsStackView.arrangedSubviews.forEach { [weak self] view in
            self?.updateColorAndFont?(color, font)
            if let button = view as? ReusableButton {
                button.setImage(nil, for: .normal)
                if let font = font {
                    button.backgroundColor = .backgroundGray
                    button.setTitleColor(.black, for: .normal)
                }
            }
        }
        selectedButton?.setImage(image, for: .normal)
        if font != nil {
            selectedButton?.backgroundColor = .black
            selectedButton?.setTitleColor(.white, for: .normal)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(presentable: Presentable) {
        
        for (index, config) in presentable.buttonConfig.enumerated() {
            let button: ReusableButton
            if index < roundedButtonsStackView.arrangedSubviews.count {
                guard let existingButton = roundedButtonsStackView.arrangedSubviews[index] as? ReusableButton else { continue }
                button = existingButton
            } else {
                button = ReusableButton()
                roundedButtonsStackView.addArrangedSubview(button)
            }
            
            titleLabel.text = presentable.title
            button.setTitle(config.title, for: .normal)
            button.titleLabel?.font = config.font
            button.setTitleColor(config.textColor, for: .normal)
            button.backgroundColor = config.backgroundcolor
            button.setImage(config.image, for: .normal)
            button.onTap = { [weak self] color, _ in
                self?.handleButtonTap(color: color ?? .black, selectedButton: button, image: presentable.buttonConfig[0].image, font: presentable.buttonConfig[2].font)
            }
        }
        
        if roundedButtonsStackView.arrangedSubviews.count > presentable.buttonConfig.count {
            for _ in presentable.buttonConfig.count..<roundedButtonsStackView.arrangedSubviews.count {
                roundedButtonsStackView.arrangedSubviews.last?.removeFromSuperview()
            }
        }
    }
}

private extension AppearanceCell {
    func setup() {
        contentView.addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor,
                          bottom: nil,
                          leading: leadingAnchor,
                          trailing: trailingAnchor,
                          padding: UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0))
        
        contentView.addSubview(roundedButtonsStackView)
        roundedButtonsStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        roundedButtonsStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        roundedButtonsStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
//        roundedButtonsStackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        configureRoundedButtonsStackView()
    }
    
    func configureRoundedButtonsStackView() {
        [leftButton, middleButton, rightButton].forEach { button in
            roundedButtonsStackView.addArrangedSubview(button)
            button.heightAnchor.constraint(equalToConstant: 45).isActive = true
            button.widthAnchor.constraint(equalToConstant: 45).isActive = true
            button.backgroundColor = .blue
        }
    }
}
