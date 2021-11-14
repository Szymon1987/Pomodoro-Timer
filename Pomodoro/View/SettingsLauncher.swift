//
//  Settings.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 20/10/2021.
//

import UIKit

class SettingsLauncher: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var pomodoroVC: PomodoroViewController?
    
    let pomodoroArray = (10...60).map{($0)}
    let shortBreakArray = (3...10).map{($0)}
    let longBreakArray = (10...20).map{($0)}
    
    
    // set default value for this
    var pomodoroMinutes = 25
    var shortBreakTime = 5
    var longBreakTime = 10
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pomodoroPickerView {
            return pomodoroArray.count
        } else if pickerView == shortBreakPickerView {
            return shortBreakArray.count
        } else {
            return longBreakArray.count
        }

    }
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//
//        if pickerView == pomodoroPickerView {
//            return String(pomodoroArray[row])
//        } else if pickerView == shortBreakPickerView {
//            return String(shortBreakArray[row])
//        } else {
//            return String(longBreakArray[row])
//        }
//
//    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    
        var labelText: String?
        
            if pickerView == pomodoroPickerView {
                labelText = "\(pomodoroArray[row]) min"
                
            } else if pickerView == shortBreakPickerView {
                labelText = "\(shortBreakArray[row]) min"
            } else {
                labelText = "\(longBreakArray[row]) min"
            }
        
        
        var label: UILabel? = (view as? UILabel)
        if label == nil {
            label = UILabel()
            label?.font = UIFont.boldSystemFont(ofSize: 16)
            label?.textAlignment = .center
            label?.text = labelText
            label?.textColor = .black
        }
        return label!
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return topContainerView.frame.height * 0.20
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch pickerView {
        case pomodoroPickerView:
            pomodoroMinutes = pomodoroArray[row]
        case shortBreakPickerView:
            shortBreakTime = shortBreakArray[row]
        default:
            longBreakTime = longBreakArray[row]
        }
//        if pickerView == pomodoroPickerView {
//            pomodoroMinutes = String(pomodoroArray[row])
//            print(pomodoroMinutes)
//        } else if pickerView == shortBreakPickerView {
//            shortBreakTime = String(shortBreakArray[row])
//        } else {
//            longBreakTime = String(longBreakArray[row])
//        }
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        showSettings()
        setUpTopContainerView()
        setUpMiddleContainerView()
        setUpBottomContainerView()
//        shortBreakPickerView.delegate = self
//        shortBreakPickerView.dataSource = self
        backgroundColor = .white
        
        // chooses the default vaule for the minutes
        self.pomodoroPickerView.selectRow(15, inComponent: 0, animated: false)
//        self.shortBreakPickerView.selectRow(15, inComponent: 0, animated: false)
//        self.longBreakPickerView.selectRow(15, inComponent: 0, animated: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let settingsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "   Settings"
        label.font = UIFont.boldSystemFont(ofSize: 26)
        return label
    }()

    lazy var xmarkView: UIImageView = {
        let image = UIImage(systemName: "xmark")
        let imageView = UIImageView(image: image)
        imageView.tintColor = .systemGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        return imageView
    }()
    
    let applyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Apply", for: .normal)
        let applyButtonColor = ColorManager.pomodoroOrange
        button.backgroundColor = applyButtonColor
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 26
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(applyButtonPressed), for: .touchUpInside)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
 
    @objc func applyButtonPressed() {
        
        if let pomodoroVC = pomodoroVC {
            pomodoroVC.didUpdateTimer(pomodoroMinutes: pomodoroMinutes)
        }
    }
    
    @objc func handleDismiss() {
        self.removeFromSuperview()
    }
    
    let topContainerView: UIView = {
        let view = UIView()
//        view.backgroundColor = .yellow
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    
    let timeMinutesLabel: UILabel = {
        let label = UILabel()
        label.text = "TIME (MINUTES)"
        label.textAlignment = .center
//        label.backgroundColor = .red
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let topDividerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    let middleDividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let pomodoroLabel: UILabel = {
        let label = UILabel()
//        label.backgroundColor = .red
        label.text = "    pomodoro"
        return label
    }()
    
    let shortBreakLabel: UILabel = {
        let label = UILabel()
//        label.backgroundColor = .blue
        label.text = "    short break"
        return label
    }()
    
    let longBreakLabel: UILabel = {
        let label = UILabel()
//        label.backgroundColor = .green
        label.text = "    long break"
        return label
    }()

    
    lazy var pomodoroPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.translatesAutoresizingMaskIntoConstraints = false
//        self.pickerView.selectRow(1, inComponent: 0, animated: false)
        return pickerView
    }()

    lazy var shortBreakPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.clipsToBounds = true
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    
    lazy var longBreakPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()
    
    func setUpTopContainerView() {

        translatesAutoresizingMaskIntoConstraints = false
        
        [timeMinutesLabel, topDividerView, middleDividerView, shortBreakLabel, longBreakLabel, pomodoroLabel].forEach{topContainerView.addSubview($0)}
        
        
        topDividerView.anchor(top: topContainerView.topAnchor, bottom: nil, leading: topContainerView.leadingAnchor, trailing: topContainerView.trailingAnchor, size: .init(width: 0, height: 1))
 

        middleDividerView.anchor(top: nil, bottom: topContainerView.bottomAnchor, leading: topContainerView.leadingAnchor, trailing: topContainerView.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: -20), size: .init(width: 0, height: 1))

        timeMinutesLabel.anchor(top: topDividerView.bottomAnchor, bottom: nil, leading: topContainerView.leadingAnchor, trailing: topContainerView.trailingAnchor, padding: .init(top: 12, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 30))
        
        
        shortBreakLabel.anchor(top: nil, bottom: nil, leading: topContainerView.leadingAnchor, trailing: nil)
        shortBreakLabel.centerYAnchor.constraint(equalTo: topContainerView.centerYAnchor, constant: 20).isActive = true
        shortBreakLabel.widthAnchor.constraint(equalTo: topContainerView.widthAnchor, multiplier: 0.5).isActive = true
        shortBreakLabel.heightAnchor.constraint(equalTo: topContainerView.heightAnchor, multiplier: 0.15).isActive = true

        longBreakLabel.anchor(top: shortBreakLabel.bottomAnchor, bottom: nil, leading: topContainerView.leadingAnchor, trailing: nil, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        longBreakLabel.widthAnchor.constraint(equalTo: topContainerView.widthAnchor, multiplier: 0.5).isActive = true
        longBreakLabel.heightAnchor.constraint(equalTo: shortBreakLabel.heightAnchor).isActive = true
        
        pomodoroLabel.anchor(top: nil, bottom: shortBreakLabel.topAnchor, leading: topContainerView.leadingAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: -10, right: 0))
        pomodoroLabel.widthAnchor.constraint(equalTo: shortBreakLabel.widthAnchor).isActive = true
        pomodoroLabel.heightAnchor.constraint(equalTo: shortBreakLabel.heightAnchor).isActive = true
        
        
        topContainerView.addSubview(shortBreakPickerView)

        shortBreakPickerView.widthAnchor.constraint(equalTo: topContainerView.widthAnchor, multiplier: 0.5).isActive = true
        shortBreakPickerView.trailingAnchor.constraint(equalTo: topContainerView.trailingAnchor).isActive = true
        shortBreakPickerView.centerYAnchor.constraint(equalTo: shortBreakLabel.centerYAnchor).isActive = true
        shortBreakPickerView.heightAnchor.constraint(equalTo: shortBreakLabel.heightAnchor).isActive = true

        topContainerView.addSubview(pomodoroPickerView)
        
        pomodoroPickerView.anchor(top: nil, bottom: shortBreakPickerView.topAnchor, leading: nil, trailing: topContainerView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: -10, right: 0))
        pomodoroPickerView.widthAnchor.constraint(equalTo: shortBreakPickerView.widthAnchor).isActive = true
        pomodoroPickerView.heightAnchor.constraint(equalTo: shortBreakPickerView.heightAnchor).isActive = true
    
        topContainerView.addSubview(longBreakPickerView)
        
        longBreakPickerView.anchor(top: shortBreakPickerView.bottomAnchor, bottom: nil, leading: nil, trailing: topContainerView.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        longBreakPickerView.widthAnchor.constraint(equalTo: shortBreakPickerView.widthAnchor).isActive = true
        longBreakPickerView.heightAnchor.constraint(equalTo: shortBreakPickerView.heightAnchor).isActive = true
        
    }
    
    
    let middleContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let fontLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "FONT"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    lazy var centerFontView: CircleFontView = {
        let view = CircleFontView()
        view.label.font = UIFont(name: "Apple SD Gothic Neo Heavy", size: 13)
        view.label.text = "Aa"
        let tap = UITapGestureRecognizer(target: self, action: #selector(fontIconTapped))
        view.addGestureRecognizer(tap)
        tap.view?.tag = 1
        return view
    }()
    
    lazy var leftFontView: CircleFontView = {
        let view = CircleFontView()
        view.backgroundColor = .black
        view.label.textColor = .white
        view.label.font = UIFont(name: "MalayalamSangamMN", size: 13)
        view.label.text = "Aa"
        let tap = UITapGestureRecognizer(target: self, action: #selector(fontIconTapped))
        view.addGestureRecognizer(tap)
        tap.view?.tag = 0
        return view
    }()
    
    lazy var rightFontView: CircleFontView = {
        let view = CircleFontView()
        view.label.font = UIFont(name: "ChalkboardSE-Bold", size: 13)
        view.label.text = "Aa"
        let tap = UITapGestureRecognizer(target: self, action: #selector(fontIconTapped))
        view.addGestureRecognizer(tap)
        tap.view?.tag = 2
        return view
    }()
    
    @objc func fontIconTapped(sender: UITapGestureRecognizer) {
        guard let getTag = sender.view?.tag else { return }
        updateFontColor(selectedTag: getTag)
    }
    
    func updateFontColor(selectedTag: Int) {
        let views = [leftFontView, centerFontView, rightFontView]
        for view in views {
            view.backgroundColor = #colorLiteral(red: 0.9333208203, green: 0.9437040687, blue: 0.9826990962, alpha: 1)
            view.label.textColor = .black
        }
        views[selectedTag].backgroundColor = .black
        views[selectedTag].label.textColor = .white
      
    }
    
    func setUpMiddleContainerView() {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        [fontLabel, centerFontView, leftFontView, rightFontView].forEach{middleContainerView.addSubview($0)}
        
        fontLabel.anchor(top: middleContainerView.topAnchor, bottom: nil, leading: middleContainerView.leadingAnchor, trailing: middleContainerView.trailingAnchor, padding: .init(top: 15, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 40))

        centerFontView.anchor(top: nil, bottom: nil, leading: nil, trailing: nil, size: .init(width: 44, height: 44))
        centerFontView.centerXAnchor.constraint(equalTo: middleContainerView.centerXAnchor).isActive = true
        centerFontView.centerYAnchor.constraint(equalTo: middleContainerView.centerYAnchor, constant: 20).isActive = true
        
        leftFontView.anchor(top: nil, bottom: centerFontView.bottomAnchor, leading: nil, trailing: centerFontView.leadingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: -10))
        leftFontView.anchorSize(to: centerFontView)


        rightFontView.anchor(top: nil, bottom: centerFontView.bottomAnchor, leading: centerFontView.trailingAnchor, trailing: nil, padding: .init(top: 0, left: 10, bottom: 0, right: 0))
        rightFontView.anchorSize(to: centerFontView)
    }

    let bottomContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let colorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "COLOR"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let bottomDividerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var centerColorView: CircleColorView = {
        let view = CircleColorView()
        view.backgroundColor = ColorManager.pomodoroBlue
        let tap = UITapGestureRecognizer(target: self, action: #selector(colorIconTapped))
        view.addGestureRecognizer(tap)
        tap.view?.tag = 1
        return view
    }()

    lazy var leftColorView: CircleColorView = {
        let view = CircleColorView()
        view.checkMarkView.isHidden = false
        view.backgroundColor = ColorManager.pomodoroOrange
        let tap = UITapGestureRecognizer(target: self, action: #selector(colorIconTapped))
        view.addGestureRecognizer(tap)
        tap.view?.tag = 0
        return view
    }()
    
    
    lazy var rightColorView: CircleColorView = {
        let view = CircleColorView()
        view.backgroundColor = ColorManager.pomodoroPurple
        let tap = UITapGestureRecognizer(target: self, action: #selector(colorIconTapped))
        view.addGestureRecognizer(tap)
        tap.view?.tag = 2
        return view
    }()
    
    
    @objc func colorIconTapped(sender: UITapGestureRecognizer) {
        guard let getTag = sender.view?.tag else { return }
        updateCheckmarkPosition(selectedTag: getTag)
    }
    
    func updateCheckmarkPosition(selectedTag: Int) {
        let views = [leftColorView, centerColorView, rightColorView]
        for view in views {
            view.checkMarkView.isHidden = true
        }
        views[selectedTag].checkMarkView.isHidden = false
        
    }

    func setUpBottomContainerView() {
        translatesAutoresizingMaskIntoConstraints = false
        [colorLabel,bottomDividerView, centerColorView, leftColorView, rightColorView,].forEach{bottomContainerView.addSubview($0)}

        colorLabel.anchor(top: bottomContainerView.topAnchor, bottom: nil, leading: bottomContainerView.leadingAnchor, trailing: bottomContainerView.trailingAnchor, padding: .init(top: 15, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 40))

        bottomDividerView.anchor(top: bottomContainerView.topAnchor, bottom: nil, leading: bottomContainerView.leadingAnchor, trailing: bottomContainerView.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: -20), size: .init(width: 0, height: 1))


        centerColorView.anchor(top: nil, bottom: nil, leading: nil, trailing: nil, size: .init(width: 44, height: 44))

        centerColorView.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor).isActive = true
        centerColorView.centerYAnchor.constraint(equalTo: bottomContainerView.centerYAnchor).isActive = true

        leftColorView.anchor(top: nil, bottom: centerColorView.bottomAnchor, leading: nil, trailing: centerColorView.leadingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: -10))
        leftColorView.anchorSize(to: centerColorView)

        rightColorView.anchor(top: nil, bottom: centerColorView.bottomAnchor, leading: centerColorView.trailingAnchor, trailing: nil, padding: .init(top: 0, left: 10, bottom: 0, right: 0))

        rightColorView.anchorSize(to: centerColorView)
 
    }

    
    private func showSettings() {
        self.translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 20
        
        addSubview(settingsLabel)
        
        settingsLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        settingsLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        settingsLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        settingsLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15).isActive = true
        
        addSubview(xmarkView)
        
        xmarkView.centerYAnchor.constraint(equalTo: settingsLabel.centerYAnchor).isActive = true
        xmarkView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        xmarkView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        xmarkView.trailingAnchor.constraint(equalTo: settingsLabel.trailingAnchor, constant: -20).isActive = true
        
        
        addSubview(topContainerView)
        
        topContainerView.topAnchor.constraint(equalTo: settingsLabel.bottomAnchor).isActive = true
        topContainerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        topContainerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        topContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.35).isActive = true
        
        
        addSubview(middleContainerView)
        
        middleContainerView.topAnchor.constraint(equalTo: topContainerView.bottomAnchor).isActive = true
        middleContainerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        middleContainerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        middleContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25).isActive = true
        
        addSubview(bottomContainerView)
        
        
        bottomContainerView.topAnchor.constraint(equalTo: middleContainerView.bottomAnchor).isActive = true
        bottomContainerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        bottomContainerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        bottomContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25).isActive = true
    
        addSubview(applyButton)
        
        applyButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.40).isActive = true
        applyButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        applyButton.topAnchor.constraint(equalTo: bottomAnchor, constant: -30).isActive = true
        applyButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
    
    }
    
    
}

