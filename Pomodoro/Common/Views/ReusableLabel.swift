import UIKit

final class ReusableLabel: UILabel {
    
    public var isChosen: Bool = false

    init(text: String = "",
         fontSize: CGFloat = 18,
         textColor: UIColor = .black,
         textAlignment: NSTextAlignment = .center) {
        super.init(frame: .zero)
        setupLabel(text: text, fontSize: fontSize, textColor: textColor, textAlignment: textAlignment)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLabel(text: String, fontSize: CGFloat, textColor: UIColor, textAlignment: NSTextAlignment) {

        self.font = UIFont.normalFont(size: fontSize)
        self.text = text
        self.textColor = textColor
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.5
        self.textAlignment = textAlignment
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.masksToBounds = true
        
    }
}
