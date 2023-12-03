import UIKit

enum TimerStage {
    case pomodoro
    case shortBreak
    case longBreak
    case finished
}

final class PomodoroTimerViewModel {
    
    private let stages: [TimerStage] = [.pomodoro, .shortBreak, .pomodoro, .longBreak, .pomodoro, .finished]
    private var currentStageIndex = 0
    
    private let timeDurationModel = TimeDurationModel()
    private let countDownTimer = CountDownTimer()
    
    var updateClockViewTimeLabel: ((String) -> Void)?
    var updateClockViewStartStopLabel: ((String) -> Void)?
    
    init() {
        countDownTimer.onTick = { [weak self] remainingTime in
            let timeString = self?.formatTimeInterval(remainingTime)
            self?.updateClockViewTimeLabel?(timeString ?? "00:00")
        }
        countDownTimer.onCompletionCycle = { [weak self] in
            self?.advanceToNextStage()
        }
    }
    
    private func formatTimeInterval(_ interval: TimeInterval) -> String {
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
    
    private func advanceToNextStage() {
        currentStageIndex += 1
        startNextStage()
    }
    
    private func startNextStage() {
        guard currentStageIndex < stages.count else {
            print("Timer sequence finished")
            return
        }
        let currentStage = stages[currentStageIndex]
        let duration = TimeInterval(timeDurationModel.duration(for: currentStage))
        if currentStage != .finished {
            countDownTimer.startCountdown(duration: duration)
        } else {
            updateClockViewStartStopLabel?("START")
            print("Timer sequence finished")
        }
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

