import UIKit

class TimerStateStackView: UIStackView {
    
    let pomodoroLabel: ReusableLabel
    let shortBreakLabel: ReusableLabel
    let longBreakLabel: ReusableLabel
    
    init() {
        pomodoroLabel = ReusableLabel(text: "pomodoro", textColor: .darkPurple)
        shortBreakLabel = ReusableLabel(text: "short break", textColor: .lightTextColor)
        longBreakLabel = ReusableLabel(text: "long break", textColor: .lightTextColor)
        super.init(frame: .zero)
        setupTimerStateStackView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func updateLabelBackgroundColor(with color: UIColor) {
        pomodoroLabel.isChosen = true
        [pomodoroLabel, shortBreakLabel, longBreakLabel].filter { $0.isChosen == true }.forEach {
            $0.backgroundColor = color
        }
    }
    
    public func updateViews(state: TimerStage, backgroundColor: UIColor) {
        [pomodoroLabel, shortBreakLabel, longBreakLabel].forEach {
            $0.backgroundColor = .darkPurple
            $0.textColor = .lightTextColor
            $0.isChosen = false
        }
               switch state {
               case .pomodoro:
                   pomodoroLabel.backgroundColor = backgroundColor
                   pomodoroLabel.isChosen = true
                   pomodoroLabel.textColor = .darkPurple
               case .shortBreak:
                   shortBreakLabel.isChosen = true
                   shortBreakLabel.backgroundColor = backgroundColor
                   shortBreakLabel.textColor = .darkPurple
               case .longBreak:
                   longBreakLabel.isChosen = true
                   longBreakLabel.backgroundColor = backgroundColor
                   longBreakLabel.textColor = .darkPurple
               case .finished:
                   pomodoroLabel.isChosen = true
                   pomodoroLabel.backgroundColor = backgroundColor
                   pomodoroLabel.textColor = .darkPurple
               }
    }
   
    private func setupTimerStateStackView() {
        backgroundColor = UIColor.darkPurple
        layer.masksToBounds = true
        addArrangedSubview(pomodoroLabel)
        addArrangedSubview(shortBreakLabel)
        addArrangedSubview(longBreakLabel)
        translatesAutoresizingMaskIntoConstraints = false
        
        distribution = .fillEqually
        spacing = 5
        
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = UIEdgeInsets(top: 7, left: 10, bottom: 7, right: 10)
        pomodoroLabel.backgroundColor = .pomodoroOrange
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        [pomodoroLabel, shortBreakLabel, longBreakLabel].forEach{$0.layer.cornerRadius = pomodoroLabel.frame.height / 2}
        self.layer.cornerRadius = self.frame.height / 2
    }
}
