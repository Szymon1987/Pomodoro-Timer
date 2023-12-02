import UIKit

class AppCoordinator {
    private let window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let pomodoroVC = PomodoroSceneBuilder.buildPomodoroTimerViewController()
        window?.rootViewController = pomodoroVC
        window?.makeKeyAndVisible()
    }
    
    func showSettings() {
        _ = PomodoroSceneBuilder.buildPomodoroSettingsViewController()
    }
}
