import UIKit

final class PomodoroTimerViewController: UIViewController {
    
    private let viewModel: PomodoroTimerViewModel
    private let coordinator: AppCoordinator
    
    private let titleLabel: ReusableLabel = {
        let label = ReusableLabel(text: "pomodoro", fontSize: 24, textColor: .white)
        return label
    }()
    
    private lazy var settingsButton: ReusableButton = {
        let button = ReusableButton(imageName: "settingsIcon")
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(settingsIconTapped)))
        return button
    }()
    
    private let timerStateStackView: TimerStateStackView = {
        let stackView = TimerStateStackView()
        return stackView
    }()
    
    private let timerBackgroundView: TimerBackgroundView = {
        let view = TimerBackgroundView()
        return view
    }()
    
    
    private lazy var clockView: ClockView = {
        let view = ClockView()
        return view
    }()

    init(viewModel: PomodoroTimerViewModel, coordinator: AppCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        setup()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clockView.startStopButtonTapped = { [weak self] isRunning in
            self?.viewModel.startStopButtonTapped(isRunning: isRunning)
        }
        viewModel.updateClockViewTimeLabel = { [weak clockView] timeString in
            clockView?.updateTimeLabel(timeString: timeString)
               }
        viewModel.onFinishAllCycles = { [weak clockView] in
            clockView?.allCyclesFinished(pomodoroTime: TimeDurationModel.defaultPomodoroDuration.toFormattedTimeString())
               }
        viewModel.onStageChange = { [weak self] state in
            self?.stageChanges(state: state)
        }
    }
    
    private func stageChanges(state: TimerStage) {
        timerStateStackView.updateViews(state: state)
    }
    
    @objc private func settingsIconTapped() {
        Haptics.light()
        coordinator.showSettings(delegate: self)
    }
}

private extension PomodoroTimerViewController {
    func setup() {
        
        view.backgroundColor = .backgroundPurple
        
        [titleLabel, timerStateStackView, timerBackgroundView, clockView, settingsButton]
            .forEach { view.addSubview($0) }
        
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07).isActive = true
        
        timerStateStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        timerStateStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        timerStateStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30).isActive = true
        timerStateStackView.heightAnchor.constraint(equalTo:view.heightAnchor, multiplier: 0.08).isActive = true
        
        timerBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        timerBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        timerBackgroundView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        timerBackgroundView.heightAnchor.constraint(equalTo: timerBackgroundView.widthAnchor).isActive = true
        
        clockView.centerXAnchor.constraint(equalTo: timerBackgroundView.centerXAnchor).isActive = true
        clockView.centerYAnchor.constraint(equalTo: timerBackgroundView.centerYAnchor).isActive = true
        clockView.heightAnchor.constraint(equalTo: timerBackgroundView.heightAnchor, constant: -35).isActive = true
        clockView.widthAnchor.constraint(equalTo: timerBackgroundView.heightAnchor, constant: -35).isActive = true
        
        settingsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        settingsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        settingsButton.heightAnchor.constraint(equalToConstant: 28).isActive = true
        settingsButton.widthAnchor.constraint(equalToConstant: 28).isActive = true
    }
}


extension PomodoroTimerViewController: AppearanceSettingsViewControllerDelegate {
    func settingsViewControllerDidUpdateAppearance(appearanceModel: AppearanceModel) {
        print("aaaaaa \(appearanceModel.color) and font \(appearanceModel.font)")
        updateColorAndFont(appearanceModel: appearanceModel)
    }
}

private extension PomodoroTimerViewController {
    func updateColorAndFont(appearanceModel: AppearanceModel) {
        titleLabel.font = appearanceModel.font
        
        clockView.updateAppearance(appearanceModel: appearanceModel)
    }
}

