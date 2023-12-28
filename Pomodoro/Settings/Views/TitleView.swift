import UIKit

final class TitleView: UIView {
    
    private let dividerView = DividerView()
    
    private let settingsLabel: ReusableLabel = {
        let label = ReusableLabel(text: "Settings", fontSize: 26, textColor: .black, textAlignment: .left)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(settingsLabel)
        settingsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25).isActive = true
        settingsLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
        settingsLabel.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
       
        addSubview(dividerView)
        dividerView.anchor(top: nil, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, size: .init(width: 0, height: 1))
    }
}
