import UIKit

final class AppCoordinator {
    private let window: UIWindow?
    private var pomodoroVC: PomodoroTimerViewController?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let pomodoroVC = PomodoroSceneBuilder.buildPomodoroTimerViewController(coordinator: self) as! PomodoroTimerViewController
        window?.rootViewController = pomodoroVC
        self.pomodoroVC = pomodoroVC
        window?.makeKeyAndVisible()
    }
    
    func showSettings(delegate: PomodoroTimerViewController) {
        let settingsVC = PomodoroSceneBuilder.buildPomodoroSettingsViewController(coordinator: self) as! SettingsViewController
        settingsVC.delegate = delegate
        window?.rootViewController?.present(settingsVC, animated: true)
    }
}
