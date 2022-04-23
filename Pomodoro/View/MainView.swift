//
//  SharePromptView.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 09/03/2022.
//

import UIKit

class MainView: UIView {
 
    let titleLabel: ReusableLabel
    let timerStateStackView = TimerStateStackView()
    let timerView = TimerView()
    let settingsButton: ReusableButton
    let timerEngine = TimerEngine()

    private lazy var settingsView: SettingsView = {
        let st = SettingsView(mainView: self, configurableTimerModel: timerEngine.timerModel, configurableAppearanceModel: timerEngine.appearanceModel)
        st.mainView = self
        return st
    }()
    
    // MARK: - Initialization
    
    init() {
        titleLabel = ReusableLabel(text: "pomodoro", fontSize: 24, textColor: .white)
        settingsButton = ReusableButton(imageName: "settingsIcon")
        super.init(frame: .zero)
        backgroundColor = .backgroundPurple
        createSubviews()
        configureSettingsButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // MARK: - Helpers
    
    private func configureSettingsButton() {
        settingsButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(settingsIconTapped)))
    }
    
    // MARK: - UIActions

    @objc private func settingsIconTapped() {
        Haptics.light()
        setupSettingsView()
    }

    var totalSeconds: Int = 6
    var pomodoroSeconds: Int = 6
    var shortBreakSeconds: Int = 2
    var longBreakSeconds: Int = 4
    
    var timerCounting: Bool = false
    var startTime: Date?
    var stopTime: Date?
    var scheduledTimer: Timer!
    var currentState: Int = 1
 
    // MARK: - Adding Subviews

    func createSubviews() {

        addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.07).isActive = true

        addSubview(timerStateStackView)
        timerStateStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        timerStateStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        timerStateStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30).isActive = true
        timerStateStackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.08).isActive = true
      
        addSubview(timerView)
        timerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        timerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        timerView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        timerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.35).isActive = true
        timerView.heightAnchor.constraint(equalTo: timerView.widthAnchor).isActive = true
        
        addSubview(settingsButton)
        settingsButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        settingsButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        settingsButton.heightAnchor.constraint(equalToConstant: 28).isActive = true
        settingsButton.widthAnchor.constraint(equalToConstant: 28).isActive = true
    }
    
    private func setupSettingsView() {

        addSubview(settingsView)
        settingsView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        settingsView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -60).isActive = true
        settingsView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        settingsView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
    }
    
}
    
  
    


