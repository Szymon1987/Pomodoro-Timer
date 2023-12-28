import UIKit

final class AppCoordinator {
    private let window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let pomodoroVC = PomodoroSceneBuilder.buildPomodoroTimerViewController(coordinator: self) as! PomodoroTimerViewController
        window?.rootViewController = pomodoroVC
        window?.makeKeyAndVisible()
    }
    
    func showSettings(delegate: PomodoroTimerViewModel) {
        let settingsVC = PomodoroSceneBuilder.buildPomodoroSettingsViewController(coordinator: self) as! SettingsViewController
        settingsVC.delegate = delegate
        window?.rootViewController?.present(settingsVC, animated: true)
    }
}
