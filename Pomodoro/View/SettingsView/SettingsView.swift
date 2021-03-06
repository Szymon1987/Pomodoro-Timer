////
////  NewSettingsView.swift
////  Pomodoro
////
////  Created by Szymon Tadrzak on 21/03/2022.
////
//
//import UIKit
//
//class SettingsView: UIView {
//
//    weak var mainView: MainView?
//    let titleView = TitleView()
//    let xmarkButton: ReusableButton
//    let middleTopView = MiddleTopView()
//    let fontView = FontView()
//    let colorView = ColorView()
//    let dividerView = DividerView()
//    let applyButton: ReusableButton
//    var configurableTimerModel: TimerModel
//    var configurableAppearanceModel: AppearanceModel
//
//    init(mainView: MainView? = nil, configurableTimerModel: TimerModel, configurableAppearanceModel: AppearanceModel) {
//        self.mainView = mainView
//        self.xmarkButton = ReusableButton(systemImageName: "xmark")
//        self.applyButton = ReusableButton(title: "Apply", fontType: .boldFont(size: 22), textColor: .white, backgroundColor: .pomodoroOrange)
//        self.configurableTimerModel = configurableTimerModel
//        self.configurableAppearanceModel = configurableAppearanceModel
//        super.init(frame: .zero)
//        self.colorView.delegate = self
//        setupViews()
//        configureXmarkButton()
//        configureApplyButton()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private func configureXmarkButton() {
//        xmarkButton.tintColor = .systemGray
//        xmarkButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
//    }
//
//    @objc func handleDismiss() {
//        Haptics.light()
//        /// improve the function, find proper animation for dismissing the view
//
////        UIView.animate(withDuration: 3,
////            delay: 0.0,
////            options: .transitionCrossDissolve,
////                       animations: { self.frame.size.height = 0 },
////            completion: { complete in
////                self.removeFromSuperview()
////            })
//
//
////        UIView.animate(withDuration: 2, delay: 0.2, options: .curveEaseInOut, animations: {
//////                self.alpha = 0
////            self.topAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
////            }) { _ in
////                self.removeFromSuperview()
////                self.alpha = 1
////            }
//        self.removeFromSuperview()
//    }
//
//    private func configureApplyButton() {
//        applyButton.addTarget(self, action: #selector(applyButtonPressed), for: .touchUpInside)
//        applyButton.layer.cornerRadius = 25
//    }
//
//    @objc func applyButtonPressed() {
//        mainView?.timerEngine.timerModel = configurableTimerModel
////        mainView?.timerEngine.appearanceModel = configurableAppearanceModel
//        self.removeFromSuperview()
//        Haptics.light()
//    }
//
//    private func setupViews() {
//        translatesAutoresizingMaskIntoConstraints = false
//        backgroundColor = .white
//        layer.cornerRadius = 20
//
//        addSubview(titleView)
//        titleView.topAnchor.constraint(equalTo: topAnchor).isActive = true
//        titleView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//        titleView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
//        titleView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.12).isActive = true
//
//        addSubview(xmarkButton)
//        xmarkButton.topAnchor.constraint(equalTo: topAnchor, constant: 25).isActive = true
//        xmarkButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25).isActive = true
//        xmarkButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
//        xmarkButton.widthAnchor.constraint(equalTo: xmarkButton.heightAnchor).isActive = true
//
//        addSubview(middleTopView)
//        middleTopView.topAnchor.constraint(equalTo: titleView.bottomAnchor).isActive = true
//        middleTopView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//        middleTopView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
//        middleTopView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.38).isActive = true
//
//        addSubview(fontView)
//        fontView.topAnchor.constraint(equalTo: middleTopView.bottomAnchor).isActive = true
//        fontView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//        fontView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
//        fontView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25).isActive = true
//
//        fontView.addSubview(dividerView)
//        dividerView.anchor(top: nil, bottom: fontView.bottomAnchor, leading: fontView.leadingAnchor, trailing: fontView.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: -20), size: .init(width: 0, height: 1))
//
//        addSubview(colorView)
//        colorView.topAnchor.constraint(equalTo: fontView.bottomAnchor).isActive = true
//        colorView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//        colorView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
//        colorView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
////        colorView.backgroundColor = .systemGray
//
//        colorView.addSubview(applyButton)
//        applyButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.40).isActive = true
//        applyButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
////        applyButton.heightAnchor.constraint(equalTo: colorView.heightAnchor, multiplier: 0.25).isActive = true
//        applyButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//        applyButton.centerYAnchor.constraint(equalTo: bottomAnchor).isActive = true
//    }
//}
//
//extension SettingsView: ColorViewDataSource {
//    func selectedColorUpdated(with color: UIColor) {
//        configurableAppearanceModel.color = color
//    }
//}
