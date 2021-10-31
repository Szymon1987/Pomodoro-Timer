//
//  Settings.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 20/10/2021.
//

import UIKit

class SettingsLauncher: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var pomodoroVC: PomodoroViewController?
    
    let pomodoroArray = (1...60).map{($0)}
    let shortBreakArray = (3...10).map{($0)}
    let longBreakArray = (10...20).map{($0)}
    
    
    // set default value for this
    var pomodoroMinutes = "1"
    var shortBreakTime = ""
    var longBreakTime = ""
    
    
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
            pomodoroMinutes = String(pomodoroArray[row])
        case shortBreakPickerView:
            shortBreakTime = String(shortBreakArray[row])
        default:
            longBreakTime = String(longBreakArray[row])
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
        
        
        //print(pomodoroArray, shortBreakArray, longBreakArray)
        backgroundColor = .white
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
        let applyButtonColor = UIColor(red: 241/255, green: 112/255, blue: 112/255, alpha: 1)
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
            pomodoroVC.didUpdateUI(inputMinutes: pomodoroMinutes)
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
    
    let centerFontLabel: CircleLabel = {
        let label = CircleLabel()
        label.text = "Aa"
        return label
    }()
    
    let leftFontLabel: CircleLabel = {
        let label = CircleLabel()
        label.text = "Aa"
        return label
    }()
    
    let rightFontLabel: CircleLabel = {
        let label = CircleLabel()
        label.text = "Aa"
        return label
    }()
    
    func setUpMiddleContainerView() {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        [fontLabel, centerFontLabel, leftFontLabel, rightFontLabel].forEach{middleContainerView.addSubview($0)}
        
        fontLabel.anchor(top: middleContainerView.topAnchor, bottom: nil, leading: middleContainerView.leadingAnchor, trailing: middleContainerView.trailingAnchor, padding: .init(top: 15, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 40))

        centerFontLabel.anchor(top: nil, bottom: nil, leading: nil, trailing: nil, size: .init(width: 44, height: 44))
        centerFontLabel.centerXAnchor.constraint(equalTo: middleContainerView.centerXAnchor).isActive = true
        centerFontLabel.centerYAnchor.constraint(equalTo: middleContainerView.centerYAnchor, constant: 20).isActive = true
        
        leftFontLabel.anchor(top: nil, bottom: centerFontLabel.bottomAnchor, leading: nil, trailing: centerFontLabel.leadingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: -10))
        leftFontLabel.anchorSize(to: centerFontLabel)


        rightFontLabel.anchor(top: nil, bottom: centerFontLabel.bottomAnchor, leading: centerFontLabel.trailingAnchor, trailing: nil, padding: .init(top: 0, left: 10, bottom: 0, right: 0))
        rightFontLabel.anchorSize(to: centerFontLabel)
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
    
    let centerColorLabel: CircleLabel = {
        let label = CircleLabel()
        label.backgroundColor = UIColor(red: 112/255, green: 243/255, blue: 248/255, alpha: 1)
        return label
    }()
    
    let leftColorLabel: CircleLabel = {
        let label = CircleLabel()
        label.backgroundColor = UIColor(red: 248/255, green: 112/255, blue: 112/255, alpha: 1)
        return label
    }()
    
    let rightColorLabel: CircleLabel = {
        let label = CircleLabel()
        label.backgroundColor = UIColor(red: 216/255, green: 129/255, blue: 248/255, alpha: 1)
        return label
    }()
    
    func setUpBottomContainerView() {
        
        translatesAutoresizingMaskIntoConstraints = false
        [colorLabel,bottomDividerView, centerColorLabel, leftColorLabel, rightColorLabel].forEach{bottomContainerView.addSubview($0)}

        colorLabel.anchor(top: bottomContainerView.topAnchor, bottom: nil, leading: bottomContainerView.leadingAnchor, trailing: bottomContainerView.trailingAnchor, padding: .init(top: 15, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 40))

        bottomDividerView.anchor(top: bottomContainerView.topAnchor, bottom: nil, leading: bottomContainerView.leadingAnchor, trailing: bottomContainerView.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: -20), size: .init(width: 0, height: 1))


        centerColorLabel.anchor(top: nil, bottom: nil, leading: nil, trailing: nil, size: .init(width: 44, height: 44))

        centerColorLabel.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor).isActive = true
        centerColorLabel.centerYAnchor.constraint(equalTo: bottomContainerView.centerYAnchor).isActive = true

        leftColorLabel.anchor(top: nil, bottom: centerColorLabel.bottomAnchor, leading: nil, trailing: centerColorLabel.leadingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: -10))
        leftColorLabel.anchorSize(to: centerColorLabel)

        rightColorLabel.anchor(top: nil, bottom: centerColorLabel.bottomAnchor, leading: centerColorLabel.trailingAnchor, trailing: nil, padding: .init(top: 0, left: 10, bottom: 0, right: 0))

        rightColorLabel.anchorSize(to: centerColorLabel)
   
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

