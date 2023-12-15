import UIKit

class MiddleTopView: UIView {
    
    let pomodoroMinutes = [1, 2, 3, 4, 5, 6, 7]
    let shortBreakMinutes = [1, 2, 3]
    let longBreakMinutes = [1, 2, 3, 4]
    var tempArray = [1, 2, 3, 4, 5, 6, 7]
    
    var selectedTimes: [Int]?
    
    private let titleLabel: ReusableLabel
    private let pomodoroButton: ReusableButton
    private let shortBreakButton: ReusableButton
    private let longBreakButton: ReusableButton
    private let dividerView = DividerView()
    
    private lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()
    
    override init(frame: CGRect) {
        titleLabel = ReusableLabel(text: "TIME (MINUTES)", fontSize: 20)
        pomodoroButton = ReusableButton(title: "pomodoro", backgroundColor: .backgroundGray)
        shortBreakButton = ReusableButton(title: "short break")
        longBreakButton = ReusableButton(title: "long break")
        super.init(frame: frame)
        setupViews()
        addTargetForButtons()
        //        configurePickerViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // this needs to be changed
    private func addTargetForButtons() {
        let buttons = [pomodoroButton, shortBreakButton, longBreakButton]
        for button in buttons {
            button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        }
    }
    //  the code below needs to be changed
    
    @objc private func tapped(_ sender: ReusableButton) {
        let buttons = [pomodoroButton, shortBreakButton, longBreakButton]
        for button in buttons {
            button.backgroundColor = .clear
            sender.isSelected = false
        }
        sender.backgroundColor = .backgroundGray
        sender.isSelected = true
        switch sender.currentTitle {
        case "pomodoro":
            tempArray = pomodoroMinutes
        case "short break":
            tempArray = shortBreakMinutes
        case "long break":
            tempArray = longBreakMinutes
        default:
            print("Error")
        }
        pickerView.reloadAllComponents()
    }
    
    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, bottom: nil, leading: leadingAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0))
        
        addSubview(shortBreakButton)
        shortBreakButton.anchor(top: nil, bottom: nil, leading: leadingAnchor, trailing: nil, padding: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0))
        shortBreakButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 20).isActive = true
        shortBreakButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4).isActive = true
        shortBreakButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15).isActive = true
        
        addSubview(pomodoroButton)
        pomodoroButton.anchor(top: nil, bottom: shortBreakButton.topAnchor, leading: leadingAnchor, trailing: shortBreakButton.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 15, bottom: -10, right: 0))
        pomodoroButton.heightAnchor.constraint(equalTo: shortBreakButton.heightAnchor).isActive = true
        
        addSubview(longBreakButton)
        longBreakButton.anchor(top: shortBreakButton.bottomAnchor, bottom: nil, leading: leadingAnchor, trailing: shortBreakButton.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 15, bottom: 0, right: 0))
        longBreakButton.heightAnchor.constraint(equalTo: shortBreakButton.heightAnchor).isActive = true
        
        addSubview(dividerView)
        dividerView.anchor(top: nil, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: -20), size: .init(width: 0, height: 1))
        
        addSubview(pickerView)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.topAnchor.constraint(equalTo: pomodoroButton.topAnchor).isActive = true
        pickerView.bottomAnchor.constraint(equalTo: longBreakButton.bottomAnchor).isActive = true
        pickerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        pickerView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.45).isActive = true

        [shortBreakButton, pomodoroButton, longBreakButton].forEach{$0.layer.cornerRadius = 8}
    }
}

extension MiddleTopView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        tempArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        
        "\(tempArray[row]) min"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        let buttons = [pomodoroButton, shortBreakButton, longBreakButton]
        
                
    }
}







