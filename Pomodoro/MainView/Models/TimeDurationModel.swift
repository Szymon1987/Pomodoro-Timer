import Foundation

struct TimeDurationModel {
    static let defaultPomodoroDuration:   Int = 6
    static let defaultShortBreakDuration: Int = 2
    static let defaultLongBreakDuration:  Int = 3
    
    var pomodoroSeconds: Int
    var shortBreakSeconds: Int
    var longBreakSeconds: Int
    
    internal init(pomodoroSeconds: Int = defaultPomodoroDuration,
                  shortBreakSeconds: Int = defaultShortBreakDuration,
                  longBreakSeconds: Int = defaultLongBreakDuration) {
        self.pomodoroSeconds = pomodoroSeconds
        self.shortBreakSeconds = shortBreakSeconds
        self.longBreakSeconds = longBreakSeconds
    }
    
    func duration(for stage: TimerStage) -> Int {
        switch stage {
        case .pomodoro:
            return pomodoroSeconds
        case .shortBreak:
            return shortBreakSeconds
        case .longBreak:
            return longBreakSeconds
        case .finished:
            return 0
        }
    }
}
