import UIKit

struct Haptics {
    static func light() {
        triggerHapticMethodWith(style: .light)
    }
    
    static func heavy() {
        triggerHapticMethodWith(style: .heavy)
    }
    
    static func triggerHapticMethodWith(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        UIImpactFeedbackGenerator(style: style).impactOccurred()
    }
}
