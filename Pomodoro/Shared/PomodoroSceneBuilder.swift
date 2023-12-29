import UIKit

final class PomodoroSceneBuilder {
    static func buildPomodoroTimerViewController(coordinator: AppCoordinator) -> UIViewController {
        let pomodoroTimerViewModel = PomodoroTimerViewModel()
        let vc = PomodoroTimerViewController(viewModel: pomodoroTimerViewModel, coordinator: coordinator)
        return vc
    }
    
    static func buildPomodoroSettingsViewController(coordinator: AppCoordinator) -> UIViewController {
        let pomodoroSettingsViewController = SettingsViewController(coordinator: coordinator)
        return pomodoroSettingsViewController
    }
}
