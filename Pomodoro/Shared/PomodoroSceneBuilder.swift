import UIKit

class PomodoroSceneBuilder {
    static func buildPomodoroTimerViewController() -> UIViewController {
        let pomodoroTimerViewModel = PomodoroTimerViewModel()
        let vc = PomodoroTimerViewController(viewModel: pomodoroTimerViewModel)
        return vc
    }
    
    static func buildPomodoroSettingsViewController() -> UIViewController {
        let pomodoroSettingsViewController = SettingsViewController()
        return pomodoroSettingsViewController
    }
}
