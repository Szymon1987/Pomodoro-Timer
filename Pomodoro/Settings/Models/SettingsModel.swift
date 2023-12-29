import Foundation

struct SettingsModel {
    var appearanceModel: AppearanceModel
    var timeDurationModel: TimeDurationModel
    
    static let `default` = SettingsModel(appearanceModel: .default, timeDurationModel: .default)
}
