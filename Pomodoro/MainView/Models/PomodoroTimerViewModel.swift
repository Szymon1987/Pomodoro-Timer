import UIKit

enum TimerStage {
    case pomodoro
    case shortBreak
    case longBreak
    case finished
}

final class PomodoroTimerViewModel {
    
    private let stages: [TimerStage] = [.pomodoro, .shortBreak, .pomodoro, .longBreak, .finished]
    private var currentStageIndex = 0
    
    private let timeDurationModel = TimeDurationModel()
    private let countDownTimer = CountDownTimer()
    
    var updateClockViewTimeLabel: ((String) -> Void)?
    var onFinishAllCycles: (() -> Void)?
    var onStageChange: ((TimerStage) -> Void)?
    var onSettingsChange: ((AppearanceModel)-> Void)?
    
    init() {
        countDownTimer.onTick = { [weak self] remainingTime in
            let timeString = self?.formatTimeInterval(remainingTime)
            self?.updateClockViewTimeLabel?(timeString ?? "00:00")
        }
        countDownTimer.onReset = { [weak self] in
            self?.startNextStage()
        }
    }
    
    public func formatTimeInterval(_ interval: TimeInterval) -> String {
        let minutes = Int(interval) / 60
        let seconds = Int(interval) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func startStopButtonTapped(isRunning: Bool) {
        if isRunning {
            countDownTimer.startCountdown(duration: TimeInterval(timeDurationModel.pomodoroSeconds))
        } else {
            countDownTimer.stopCountdown()
        }
    }
    
    private func startNextStage() {
        currentStageIndex += 1
        guard currentStageIndex < stages.count else {
            return
        }
        let currentStage = stages[currentStageIndex]
        onStageChange?(currentStage)
        let duration = TimeInterval(timeDurationModel.duration(for: currentStage))
        if currentStage != .finished {
            countDownTimer.startCountdown(duration: duration)
        } else {
            onFinishAllCycles?()
            currentStageIndex = 0
        }
    }
}

extension PomodoroTimerViewModel: AppearanceSettingsViewControllerDelegate {
    func settingsViewControllerDidUpdateAppearance(appearanceModel: AppearanceModel) {
        onSettingsChange?(appearanceModel)
    }
}

//    func setTimerDelegate(_ delegate: PomodoroTimerDelegate) {
//        pomodoroTimer.delegate = delegate
//
//    }
  
//
//    // MARK: - Helpers
//
//    public func setTimeLabel(_ val: Int) -> String {
//        let time = SecondsToHoursMinutesSeconds(val)
//        let timeString = makeTimeString(min: time.1, sec: time.2)
//            return timeString
//    }
//
//    private func SecondsToHoursMinutesSeconds(_ ms: Int) -> (Int, Int, Int) {
//        let hour = ms / 3600
//        let min = (ms % 3600) / 60
//        let sec = (ms % 3600) % 60
//        return (hour, min, sec)
//    }
//
//    private func makeTimeString(min: Int, sec: Int) -> String {
//        var timeString = ""
//        timeString += String(format: "%02d", min)
//        timeString += ":"
//        timeString += String(format: "%02d", sec)
//        return timeString
//    }
//}

