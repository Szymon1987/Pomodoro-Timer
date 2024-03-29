import UIKit

class FontView: UIView {
    
    private let titleLabel: ReusableLabel
    let leftRoundedFontButton: ReusableButton
    let middleRoundedFontButton: ReusableButton
    let rightRoundedFontButton: ReusableButton
    private let roundedButtonTitle = "Aa"
    
    
    // is this approach good? Should we store the font here and then access it from somewhere else?
    var selectedFont: UIFont?
    
    init() {
        titleLabel = ReusableLabel(text: "FONT")
        leftRoundedFontButton = ReusableButton(title: roundedButtonTitle, textColor: .white, backgroundColor: .black)
        middleRoundedFontButton = ReusableButton(title: roundedButtonTitle, fontType: .italicFont(size: 16) , backgroundColor: .backgroundGray)
        rightRoundedFontButton = ReusableButton(title: roundedButtonTitle, fontType: .boldFont(size: 16), backgroundColor: .backgroundGray)
        super.init(frame: .zero)
        setupViews()
        addTargetForButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        
        [titleLabel, middleRoundedFontButton, rightRoundedFontButton, leftRoundedFontButton].forEach{addSubview($0)}
        
        titleLabel.anchor(top: topAnchor, bottom: nil, leading: leadingAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0))
        
        middleRoundedFontButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        middleRoundedFontButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 10).isActive = true
        middleRoundedFontButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        middleRoundedFontButton.widthAnchor.constraint(equalToConstant: 48).isActive = true
        
        leftRoundedFontButton.centerYAnchor.constraint(equalTo: middleRoundedFontButton.centerYAnchor).isActive = true
        leftRoundedFontButton.heightAnchor.constraint(equalTo: middleRoundedFontButton.heightAnchor).isActive = true
        leftRoundedFontButton.widthAnchor.constraint(equalTo: middleRoundedFontButton.widthAnchor).isActive = true
        leftRoundedFontButton.trailingAnchor.constraint(equalTo: middleRoundedFontButton.leadingAnchor, constant: -20).isActive = true
        
        rightRoundedFontButton.centerYAnchor.constraint(equalTo: middleRoundedFontButton.centerYAnchor).isActive = true
        rightRoundedFontButton.heightAnchor.constraint(equalTo: middleRoundedFontButton.heightAnchor).isActive = true
        rightRoundedFontButton.widthAnchor.constraint(equalTo: middleRoundedFontButton.widthAnchor).isActive = true
        rightRoundedFontButton.leadingAnchor.constraint(equalTo: middleRoundedFontButton.trailingAnchor, constant: 20).isActive = true
        [titleLabel, middleRoundedFontButton, rightRoundedFontButton, leftRoundedFontButton].forEach{$0.layer.cornerRadius = 24}
    }
    
    private func addTargetForButtons() {
        let buttons = [leftRoundedFontButton, middleRoundedFontButton, rightRoundedFontButton]

        for button in buttons {
            button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        }
    }
    // what's the better way to do it?
    @objc private func tapped(_ sender: ReusableButton) {
        let buttons = [leftRoundedFontButton, middleRoundedFontButton, rightRoundedFontButton]
        for button in buttons {
            button.backgroundColor = .backgroundGray
            button.setTitleColor(.black, for: .normal)
        }
        sender.backgroundColor = .black
        sender.setTitleColor(.white, for: .normal)
        selectedFont = sender.titleLabel?.font
    }
}


