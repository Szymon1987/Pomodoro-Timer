import UIKit

class AppCoordinator {
    private let window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let pomodoroVC = PomodoroSceneBuilder.buildPomodoroTimerViewController(coordinator: self)
        window?.rootViewController = pomodoroVC
        window?.makeKeyAndVisible()
    }
    
    func showSettings() {
        let settingsVC = PomodoroSceneBuilder.buildPomodoroSettingsViewController(coordinator: self)
        window?.rootViewController?.present(settingsVC, animated: true)
    }
}
