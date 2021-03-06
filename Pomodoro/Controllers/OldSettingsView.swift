////
////  Settings.swift
////  Pomodoro
////
////  Created by Szymon Tadrzak on 20/10/2021.
////
//
//import UIKit
//
//class SettingsView: UIView {
//
//    // MARK: - Properties
//    weak var mainView: MainView?
////
//    let pomodoroArray = (1...120).map{$0}
//    let shortBreakArray = (1...120).map{$0}
//    let longBreakArray = (1...120).map{$0}
//    
//    var pomodoroMinutes = 25
//    var shortBreakMinutes = 5
//    var longBreakMinutes = 10
//    
//    private var fontName: String = "MalayalamSangamMN-Bold"
//    private var colorTheme: UIColor = UIColor.pomodoroOrange
//    
//    //MARK: - LifeCycle
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        shortBreakPickerView.isHidden = true
//        longBreakPickerView.isHidden = true
//        showSettings()
//        setUpTopContainerView()
//        setUpMiddleContainerView()
//        setUpBottomContainerView()
//        backgroundColor = .white
//        self.pomodoroPickerView.selectRow(24, inComponent: 0, animated: false)
//        self.shortBreakPickerView.selectRow(4, inComponent: 0, animated: false)
//        self.longBreakPickerView.selectRow(9, inComponent: 0, animated: false)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    //MARK: - UIComponents
//    
//    private let settingsLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "   Settings"
//        label.font = UIFont.boldSystemFont(ofSize: 26)
//        label.textColor = .black
//        return label
//    }()
//
//    private lazy var xmarkButton: UIButton = {
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.tintColor = .systemGray
//        let image = UIImage(systemName: "xmark")
//        button.setImage(image, for: .normal)
//        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
//        return button
//    }()
//    
//   private let topContainerView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    
//    private let timeMinutesLabel: UILabel = {
//        let label = UILabel()
//        label.text = "TIME (MINUTES)"
//        label.textAlignment = .center
//        label.textColor = .black
//        label.font = UIFont.systemFont(ofSize: 18)
//        return label
//    }()
//    
//   private let topDividerView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .lightGray
//        return view
//    }()
//    
//   private lazy var pomodoroLabel: TimeLabelView = {
//        let label = TimeLabelView()
//        label.text = "pomodoro"
//        label.backgroundColor = UIColor.backgroundGray
//        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(switchLabelBackground)))
//       label.tag = 1
//        return label
//    }()
//    
//    private lazy var shortBreakLabel: TimeLabelView = {
//        let label = TimeLabelView()
//        label.text = "short break"
//        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(switchLabelBackground)))
//        label.tag = 2
//        return label
//    }()
//    
//    private lazy var longBreakLabel: TimeLabelView = {
//        let label = TimeLabelView()
//        label.text = "long break"
//        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(switchLabelBackground)))
//        label.tag = 3
//        return label
//    }()
//
//    
//    private lazy var pomodoroPickerView: UIPickerView = {
//        let pickerView = UIPickerView()
//        pickerView.delegate = self
//        pickerView.dataSource = self
//        pickerView.translatesAutoresizingMaskIntoConstraints = false
//        return pickerView
//    }()
//
//    private lazy var shortBreakPickerView: UIPickerView = {
//        let pickerView = UIPickerView()
//        pickerView.translatesAutoresizingMaskIntoConstraints = false
//        pickerView.delegate = self
//        pickerView.dataSource = self
//        return pickerView
//    }()
//    
//    private lazy var longBreakPickerView: UIPickerView = {
//        let pickerView = UIPickerView()
//        pickerView.delegate = self
//        pickerView.dataSource = self
//        pickerView.translatesAutoresizingMaskIntoConstraints = false
//        return pickerView
//    }()
//    
//    private let middleDividerView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .lightGray
//        return view
//    }()
//    
//    private let middleContainerView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    
//    private let fontLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "FONT"
//        label.textAlignment = .center
//        label.textColor = .black
//        label.font = UIFont.systemFont(ofSize: 18)
//        return label
//    }()
//    
//    private lazy var centerFontView: CircleFontView = {
//        let view = CircleFontView()
//        view.label.font = UIFont(name: "ArialRoundedMTBold", size: 13)
//        let tap = UITapGestureRecognizer(target: self, action: #selector(fontIconTapped))
//        view.addGestureRecognizer(tap)
//        tap.view?.tag = 1
//        return view
//    }()
//    
//    private lazy var leftFontView: CircleFontView = {
//        let view = CircleFontView()
//        view.backgroundColor = .black
//        view.label.textColor = .white
//        view.label.font = UIFont(name: "MalayalamSangamMN-Bold", size: 13)
//        let tap = UITapGestureRecognizer(target: self, action: #selector(fontIconTapped))
//        view.addGestureRecognizer(tap)
//        tap.view?.tag = 0
//        return view
//    }()
//    
//    private lazy var rightFontView: CircleFontView = {
//        let view = CircleFontView()
//        view.label.font = UIFont(name: "ChalkboardSE-Bold", size: 13)
//        let tap = UITapGestureRecognizer(target: self, action: #selector(fontIconTapped))
//        view.addGestureRecognizer(tap)
//        tap.view?.tag = 2
//        return view
//    }()
//    
//    private let bottomDividerView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .lightGray
//        return view
//    }()
//    
//    private let bottomContainerView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    
//    private let colorLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "COLOR"
//        label.textAlignment = .center
//        label.textColor = .black
//        label.font = UIFont.systemFont(ofSize: 18)
//        return label
//    }()
//    
//    private lazy var centerColorView: CircleColorView = {
//        let view = CircleColorView()
//        view.backgroundColor = UIColor.pomodoroBlue
//        let tap = UITapGestureRecognizer(target: self, action: #selector(colorIconTapped))
//        view.addGestureRecognizer(tap)
//        tap.view?.tag = 1
//        return view
//    }()
//
//   private lazy var leftColorView: CircleColorView = {
//        let view = CircleColorView()
//        view.checkMarkView.isHidden = false
//        view.backgroundColor = UIColor.pomodoroOrange
//        let tap = UITapGestureRecognizer(target: self, action: #selector(colorIconTapped))
//        view.addGestureRecognizer(tap)
//        tap.view?.tag = 0
//        return view
//    }()
//    
//    private lazy var rightColorView: CircleColorView = {
//        let view = CircleColorView()
//        view.backgroundColor = UIColor.pomodoroPurple
//        let tap = UITapGestureRecognizer(target: self, action: #selector(colorIconTapped))
//        view.addGestureRecognizer(tap)
//        tap.view?.tag = 2
//        return view
//    }()
//    
//    let applyButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitleColor(.white, for: .normal)
//        button.setTitle("Apply", for: .normal)
//        button.backgroundColor = UIColor.pomodoroOrange
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
//        button.layer.cornerRadius = 26
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.addTarget(SettingsView.self, action: #selector(applyButtonPressed), for: .touchUpInside)
//        return button
//    }()
//    
//    //MARK: - Helpers
// 
//    @objc private func applyButtonPressed() {
//        Haptics.playLightImpact()
////        if let pomodoroVC = pomodoroVC {
////                pomodoroVC.didUpdateUI(with: pomodoroMinutes, with: shortBreakMinutes, with: longBreakMinutes, font: fontName, color: colorTheme)
////        }
//        
////        if let pomodoroTimerView = pomodoroTimerView {
////            pomodoroTimerView.didUpdateUI(with: pomodoroMinutes, with: shortBreakMinutes, with: longBreakMinutes, font: fontName, color: colorTheme)
////        }
//        removeFromSuperview()
//    }
//    
//    @objc private func handleDismiss() {
//        Haptics.playLightImpact()
//        /// improve the function, find proper animation for dismissing the view
//        let animation = CABasicAnimation()
//        animation.keyPath = "transform.scale"
//        animation.fromValue = 1
//        animation.toValue = 0.00001
//        animation.duration = 0.2
//        self.layer.add(animation, forKey: "basic")
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15, execute: self.removeFromSuperview)
//    }
// 
//    
//    @objc private func fontIconTapped(sender: UITapGestureRecognizer) {
//        guard let getTag = sender.view?.tag else { return }
//        updateFontViewBackgroundColor(selectedTag: getTag)
//        switch sender.view?.tag {
//        case 0:
//            fontName = "MalayalamSangamMN-Bold"
//        case 1:
//            fontName = "ArialRoundedMTBold"
//        case 2:
//            fontName = "ChalkboardSE-Bold"
//        default:
//            print("Error switching fonts")
//        }
//    }
//    
//    private func updateFontViewBackgroundColor(selectedTag: Int) {
//        let views = [leftFontView, centerFontView, rightFontView]
//        for view in views {
//            view.backgroundColor = UIColor.backgroundGray
//            view.label.textColor = .black
//        }
//        views[selectedTag].backgroundColor = .black
//        views[selectedTag].label.textColor = .white
//    }
//    
//    @objc private func colorIconTapped(sender: UITapGestureRecognizer) {
//        guard let getTag = sender.view?.tag else { return }
//        updateCheckmarkPosition(selectedTag: getTag)
//
//        if let senderColor = sender.view?.backgroundColor {
//            applyButton.backgroundColor = senderColor
//            colorTheme = senderColor
//        }
//    }
//    
//    private func updateCheckmarkPosition(selectedTag: Int) {
//        let views = [leftColorView, centerColorView, rightColorView]
//        views.forEach {$0.checkMarkView.isHidden = true}
//        views[selectedTag].checkMarkView.isHidden = false
//    }
//    
//    @objc func switchLabelBackground(sender: UITapGestureRecognizer) {
//        let views = [pomodoroLabel, shortBreakLabel, longBreakLabel]
//        views.forEach{$0.backgroundColor = .clear}
//        sender.view?.backgroundColor = UIColor.backgroundGray
//        
//        let pickerViews = [shortBreakPickerView, longBreakPickerView, pomodoroPickerView]
//        pickerViews.forEach{$0.isHidden = true}
//        if sender.view?.tag == 1 {
//            pomodoroPickerView.isHidden = false
//        } else if sender.view?.tag == 2 {
//            shortBreakPickerView.isHidden = false
//        } else {
//            longBreakPickerView.isHidden = false
//        }
//    }
//    
//    // MARK: - SettingUp The Views Methods
//    
//    private func setUpTopContainerView() {
//        translatesAutoresizingMaskIntoConstraints = false
//        
//        [timeMinutesLabel, topDividerView, middleDividerView, shortBreakLabel, longBreakLabel, pomodoroLabel].forEach{topContainerView.addSubview($0)}
//        
//        
//        topDividerView.anchor(top: topContainerView.topAnchor, bottom: nil, leading: topContainerView.leadingAnchor, trailing: topContainerView.trailingAnchor, size: .init(width: 0, height: 1))
// 
//
//        middleDividerView.anchor(top: nil, bottom: topContainerView.bottomAnchor, leading: topContainerView.leadingAnchor, trailing: topContainerView.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: -20), size: .init(width: 0, height: 1))
//
//        timeMinutesLabel.anchor(top: topDividerView.bottomAnchor, bottom: nil, leading: topContainerView.leadingAnchor, trailing: topContainerView.trailingAnchor, padding: .init(top: 12, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 30))
//
//        shortBreakLabel.leadingAnchor.constraint(equalTo: topContainerView.leadingAnchor, constant: 10).isActive = true
//        shortBreakLabel.centerYAnchor.constraint(equalTo: topContainerView.centerYAnchor).isActive = true
//        shortBreakLabel.heightAnchor.constraint(equalTo: topContainerView.heightAnchor, multiplier: 0.15).isActive = true
//        shortBreakLabel.widthAnchor.constraint(equalTo: topContainerView.widthAnchor, multiplier: 0.35).isActive = true
//  
//        longBreakLabel.leadingAnchor.constraint(equalTo: shortBreakLabel.leadingAnchor).isActive = true
//        longBreakLabel.heightAnchor.constraint(equalTo: shortBreakLabel.heightAnchor).isActive = true
//        longBreakLabel.widthAnchor.constraint(equalTo: shortBreakLabel.widthAnchor).isActive = true
//        longBreakLabel.topAnchor.constraint(equalTo: shortBreakLabel.bottomAnchor, constant: 10).isActive = true
//  
//        pomodoroLabel.leadingAnchor.constraint(equalTo: shortBreakLabel.leadingAnchor).isActive = true
//        pomodoroLabel.widthAnchor.constraint(equalTo: shortBreakLabel.widthAnchor).isActive = true
//        pomodoroLabel.heightAnchor.constraint(equalTo: shortBreakLabel.heightAnchor).isActive = true
//        pomodoroLabel.bottomAnchor.constraint(equalTo: shortBreakLabel.topAnchor, constant: -10).isActive = true
// 
//        topContainerView.addSubview(pomodoroPickerView)
//        pomodoroPickerView.widthAnchor.constraint(equalTo: topContainerView.widthAnchor, multiplier: 0.5).isActive = true
//        pomodoroPickerView.bottomAnchor.constraint(equalTo: longBreakLabel.bottomAnchor).isActive = true
//        pomodoroPickerView.topAnchor.constraint(equalTo: pomodoroLabel.topAnchor).isActive = true
//        pomodoroPickerView.trailingAnchor.constraint(equalTo: topContainerView.trailingAnchor).isActive = true
//        
//        topContainerView.addSubview(shortBreakPickerView)
//        shortBreakPickerView.widthAnchor.constraint(equalTo: topContainerView.widthAnchor, multiplier: 0.5).isActive = true
//        shortBreakPickerView.bottomAnchor.constraint(equalTo: longBreakLabel.bottomAnchor).isActive = true
//        shortBreakPickerView.topAnchor.constraint(equalTo: pomodoroLabel.topAnchor).isActive = true
//        shortBreakPickerView.trailingAnchor.constraint(equalTo: topContainerView.trailingAnchor).isActive = true
//        
//        topContainerView.addSubview(longBreakPickerView)
//        longBreakPickerView.widthAnchor.constraint(equalTo: topContainerView.widthAnchor, multiplier: 0.5).isActive = true
//        longBreakPickerView.bottomAnchor.constraint(equalTo: longBreakLabel.bottomAnchor).isActive = true
//        longBreakPickerView.topAnchor.constraint(equalTo: pomodoroLabel.topAnchor).isActive = true
//        longBreakPickerView.trailingAnchor.constraint(equalTo: topContainerView.trailingAnchor).isActive = true
//    }
// 
//    private func setUpMiddleContainerView() {
//        
//        translatesAutoresizingMaskIntoConstraints = false
//        
//        [fontLabel, centerFontView, leftFontView, rightFontView].forEach{middleContainerView.addSubview($0)}
//        
//        fontLabel.anchor(top: middleContainerView.topAnchor, bottom: nil, leading: middleContainerView.leadingAnchor, trailing: middleContainerView.trailingAnchor, padding: .init(top: 15, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 40))
//
//        centerFontView.anchor(top: nil, bottom: nil, leading: nil, trailing: nil, size: .init(width: 44, height: 44))
//        centerFontView.centerXAnchor.constraint(equalTo: middleContainerView.centerXAnchor).isActive = true
//        centerFontView.centerYAnchor.constraint(equalTo: middleContainerView.centerYAnchor, constant: 20).isActive = true
//        
//        leftFontView.anchor(top: nil, bottom: centerFontView.bottomAnchor, leading: nil, trailing: centerFontView.leadingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: -10))
//        leftFontView.anchorSize(to: centerFontView)
//
//
//        rightFontView.anchor(top: nil, bottom: centerFontView.bottomAnchor, leading: centerFontView.trailingAnchor, trailing: nil, padding: .init(top: 0, left: 10, bottom: 0, right: 0))
//        rightFontView.anchorSize(to: centerFontView)
//    }
//
//    private func setUpBottomContainerView() {
//        translatesAutoresizingMaskIntoConstraints = false
//        [colorLabel,bottomDividerView, centerColorView, leftColorView, rightColorView,].forEach{bottomContainerView.addSubview($0)}
//
//        colorLabel.anchor(top: bottomContainerView.topAnchor, bottom: nil, leading: bottomContainerView.leadingAnchor, trailing: bottomContainerView.trailingAnchor, padding: .init(top: 15, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 40))
//
//        bottomDividerView.anchor(top: bottomContainerView.topAnchor, bottom: nil, leading: bottomContainerView.leadingAnchor, trailing: bottomContainerView.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: -20), size: .init(width: 0, height: 1))
//
//
//        centerColorView.anchor(top: nil, bottom: nil, leading: nil, trailing: nil, size: .init(width: 44, height: 44))
//
//        centerColorView.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor).isActive = true
//        centerColorView.centerYAnchor.constraint(equalTo: bottomContainerView.centerYAnchor).isActive = true
//
//        leftColorView.anchor(top: nil, bottom: centerColorView.bottomAnchor, leading: nil, trailing: centerColorView.leadingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: -10))
//        leftColorView.anchorSize(to: centerColorView)
//
//        rightColorView.anchor(top: nil, bottom: centerColorView.bottomAnchor, leading: centerColorView.trailingAnchor, trailing: nil, padding: .init(top: 0, left: 10, bottom: 0, right: 0))
//
//        rightColorView.anchorSize(to: centerColorView)
//    }
//
//    private func showSettings() {
//        self.translatesAutoresizingMaskIntoConstraints = false
//        layer.cornerRadius = 20
//        
//        addSubview(settingsLabel)
//        
//        settingsLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//        settingsLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
//        settingsLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
//        settingsLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15).isActive = true
//        
//        addSubview(xmarkButton)
//        
//        xmarkButton.centerYAnchor.constraint(equalTo: settingsLabel.centerYAnchor).isActive = true
//        xmarkButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
//        xmarkButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
//        xmarkButton.trailingAnchor.constraint(equalTo: settingsLabel.trailingAnchor, constant: -20).isActive = true
//        
//        
//        addSubview(topContainerView)
//        
//        topContainerView.topAnchor.constraint(equalTo: settingsLabel.bottomAnchor).isActive = true
//        topContainerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
//        topContainerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//        topContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.35).isActive = true
//        
//        
//        addSubview(middleContainerView)
//        
//        middleContainerView.topAnchor.constraint(equalTo: topContainerView.bottomAnchor).isActive = true
//        middleContainerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
//        middleContainerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//        middleContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25).isActive = true
//        
//        addSubview(bottomContainerView)
//        
//        
//        bottomContainerView.topAnchor.constraint(equalTo: middleContainerView.bottomAnchor).isActive = true
//        bottomContainerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
//        bottomContainerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//        bottomContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25).isActive = true
//    
//        addSubview(applyButton)
//        
//        applyButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.40).isActive = true
//        applyButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        applyButton.topAnchor.constraint(equalTo: bottomAnchor, constant: -30).isActive = true
//        applyButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//    }
//}
//
//    // MARK: - UIPickerViewDelegate and UIPickerViewDataSource
//
//extension SettingsView: UIPickerViewDelegate, UIPickerViewDataSource {
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        if pickerView == pomodoroPickerView {
//            return pomodoroArray.count
//        } else if pickerView == shortBreakPickerView {
//            return shortBreakArray.count
//        } else {
//            return longBreakArray.count
//        }
//
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
//    
//        var labelText: String?
//        
//            if pickerView == pomodoroPickerView {
//                labelText = "\(pomodoroArray[row]) min"
//                
//            } else if pickerView == shortBreakPickerView {
//                labelText = "\(shortBreakArray[row]) min"
//            } else {
//                labelText = "\(longBreakArray[row]) min"
//            }
//        
//        
//        var label: UILabel? = (view as? UILabel)
//        if label == nil {
//            label = UILabel()
//            label?.font = UIFont.boldSystemFont(ofSize: 16)
//            label?.textAlignment = .center
//            label?.text = labelText
//            label?.textColor = .black
//        }
//        return label!
//    
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
//        return topContainerView.frame.height * 0.20
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        switch pickerView {
//        case pomodoroPickerView:
//            pomodoroMinutes = pomodoroArray[row]
//        case shortBreakPickerView:
//            shortBreakMinutes = shortBreakArray[row]
//        default:
//            longBreakMinutes = longBreakArray[row]
//        }
//        
//    }
//    
//}
