//
//  SharePromptView.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 09/03/2022.
//

import UIKit

class MainViewViewController: UIViewController {
    
    let titleLabel: ReusableLabel
    let timerStateStackView: TimerStateStackView
    let timerBackgroundView: TimerBackgroundView
    let settingsButton : ReusableButton
    let clockView: ClockView
    let timerEngine: TimerEngine
    
    //    private lazy var settingsView: SettingsView = {
    //        let st = SettingsView(mainView: self, configurableTimerModel: timerEngine.timerModel, configurableAppearanceModel: timerEngine.appearanceModel)
    //        st.mainView = self
    //        return st
    //    }()
    
    // MARK: - Initialization
    
    //    init() {
    //        titleLabel = ReusableLabel(text: "pomodoro", fontSize: 24, textColor: .white)
    //        settingsButton = ReusableButton(imageName: "settingsIcon")
    //        timerView = TimerBackgroundView(timerEngine: timerEngine)
    //        super.init(frame: .zero)
    //        backgroundColor = .backgroundPurple
    //        createSubviews()
    //        configureSettingsButton()
    //    }
    //
    
    //    required init?(coder: NSCoder) {
    //        self.titleLabel = ReusableLabel(text: "pomodoro", fontSize: 24, textColor: .white)
    //        self.settingsButton = ReusableButton(imageName: "settingsIcon")
    //        self.timerView = TimerBackgroundView(timerEngine: timerEngine)
    //        super.init(coder: coder)
    //        view.backgroundColor = .backgroundPurple
    //        createSubviews()
    //        configureSettingsButton()
    //        fatalError("init(coder:) has not been implemented")
    //    }
    
    
    
    init(timerEngine: TimerEngine) {
        self.timerEngine = timerEngine
        self.titleLabel = ReusableLabel(text: "pomodoro", fontSize: 24, textColor: .white)
        self.settingsButton = ReusableButton(imageName: "settingsIcon")
        self.timerStateStackView = TimerStateStackView()
        self.timerBackgroundView = TimerBackgroundView()
        self.clockView = ClockView(timerEngine: timerEngine)
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .backgroundPurple
        createSubviews()
        configureSettingsButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Helpers
    
    private func configureSettingsButton() {
        settingsButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(settingsIconTapped)))
    }
    
    // MARK: - UIActions
    
    @objc private func settingsIconTapped() {
        Haptics.light()
        //        setupSettingsView()
        
        let settingsVC = SettingsViewController()
        //        settingsVC.providesPresentationContextTransitionStyle = true
        //        settingsVC.definesPresentationContext = true
        //        settingsVC.modalPresentationStyle = .overCurrentContext
        //        settingsVC.modalTransitionStyle = .crossDissolve
        self.present(settingsVC, animated: true)
        //        settingsVC.view.backgroundColor = .clear
    }
    
    // MARK: - Adding Subviews
    
    func createSubviews() {
        
        view.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07).isActive = true
        
        view.addSubview(timerStateStackView)
        timerStateStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        timerStateStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        timerStateStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30).isActive = true
        timerStateStackView.heightAnchor.constraint(equalTo:view.heightAnchor, multiplier: 0.08).isActive = true
        
        view.addSubview(timerBackgroundView)
        timerBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        timerBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        timerBackgroundView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        //        timerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.35).isActive = true
        timerBackgroundView.heightAnchor.constraint(equalTo: timerBackgroundView.widthAnchor).isActive = true
        
        timerBackgroundView.addSubview(clockView)
        clockView.centerXAnchor.constraint(equalTo: timerBackgroundView.centerXAnchor).isActive = true
        clockView.centerYAnchor.constraint(equalTo: timerBackgroundView.centerYAnchor).isActive = true
        clockView.heightAnchor.constraint(equalTo: timerBackgroundView.heightAnchor, constant: -35).isActive = true
        clockView.widthAnchor.constraint(equalTo: timerBackgroundView.heightAnchor, constant: -35).isActive = true
        
        view.addSubview(settingsButton)
        settingsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        settingsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        settingsButton.heightAnchor.constraint(equalToConstant: 28).isActive = true
        settingsButton.widthAnchor.constraint(equalToConstant: 28).isActive = true
    }
    
    private func setupSettingsView() {
        //
        //        view.addSubview(settingsView)
        //        settingsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        //        settingsView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60).isActive = true
        //        settingsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        //        settingsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
    }
    
}





