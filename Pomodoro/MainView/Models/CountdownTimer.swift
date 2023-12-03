import UIKit

class CountDownTimer {
    private var timer: Timer?
    private var endTime: Date?
    private var remainingTimeWhenStopped: TimeInterval?
    private var initialDuration: TimeInterval?  // Store the initial duration

    var onTick: ((TimeInterval) -> Void)?
    var onCompletionCycle: (() -> Void)?

    func startCountdown(duration: TimeInterval) {
        initialDuration = duration  // Store the initial duration

        if let remainingTime = remainingTimeWhenStopped {
            endTime = Date().addingTimeInterval(remainingTime)
        } else {
            endTime = Date().addingTimeInterval(duration)
        }

        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.checkTimer()
        }
    }

    func stopCountdown() {
        if let endTime = endTime {
            remainingTimeWhenStopped = endTime.timeIntervalSinceNow
        }
        timer?.invalidate()
        timer = nil
    }

    private func checkTimer() {
        guard let endTime = endTime else { return }
        let remainingTime = endTime.timeIntervalSinceNow

        if remainingTime <= 0 {
            print("Timer completed")
            stopCountdown()
            resetTimer()
        } else {
            onTick?(remainingTime)
        }
    }

    private func resetTimer() {
        if let initialDuration = initialDuration {
            remainingTimeWhenStopped = nil  // Clear the remaining time
//            startCountdown(duration: initialDuration)
            onCompletionCycle?()
        }
    }
}
