import UIKit

final class ReusableButton: UIButton {

    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(imageName: String) {
        self.init()
        let image = UIImage(named: imageName)?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        imageView?.image = image
        setImage(image, for: .normal)
    }
    
    convenience init(systemImageName: String? = nil, backgroundColor: UIColor = .clear) {
        self.init()
        self.backgroundColor = backgroundColor
        guard let systemImageName = systemImageName else { return }
        let image = UIImage(systemName: systemImageName)?.withTintColor(.black, renderingMode: .alwaysOriginal)
        setImage(image, for: .normal)
    }
 
    convenience init(title: String, fontType: UIFont = .normalFont(size: 16), textColor: UIColor = .black, backgroundColor: UIColor = .clear) {
        self.init()
        setTitle(title, for: .normal)
//        titleLabel?.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont(name: "Helvetica-Bold", size: fontSize)!)
        titleLabel?.font = fontType
        setTitleColor(textColor, for: .normal)
//        titleLabel?.textColor = textColor
        self.backgroundColor = backgroundColor
    }  
}

