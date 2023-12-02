import UIKit

struct AppearanceModel {
    static let defaultColor: UIColor = .pomodoroOrange
    static let defaultFont: UIFont =   .normalFont(size: 16)
    
    var color: UIColor
    var font: UIFont
    
    init(color: UIColor = defaultColor, font: UIFont = defaultFont) {
        self.color = color
        self.font = font
    }
}
