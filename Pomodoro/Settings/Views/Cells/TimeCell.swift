import UIKit

final class TimeCell: UITableViewCell {
    
    var timeDurationModel: TimeDurationModel = .default
    
    var tempArray = Array(1...7)
    
    var onDurationSelection: ((TimeDurationModel) -> Void)?
    
    enum PickerType {
        case pomodoro, shortBreak, longBreak
    }
    
    var currentPickerType: PickerType = .pomodoro
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        titleLabel = ReusableLabel(text: "TIME (MINUTES)", fontSize: 20)
        pomodoroButton = ReusableButton(title: "pomodoro", backgroundColor: .backgroundGray)
        shortBreakButton = ReusableButton(title: "short break")
        longBreakButton = ReusableButton(title: "long break")
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
            tempArray = timeDurationModel.pomArray
            currentPickerType = .pomodoro
        case "short break":
            tempArray = timeDurationModel.shortBreakArray
            currentPickerType = .shortBreak
        case "long break":
            currentPickerType = .longBreak
            tempArray = timeDurationModel.longBreakArray
        default:
            print("Error")
        }
        
        pickerView.reloadAllComponents()
    }
    
    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        contentView.addSubview(shortBreakButton)
        shortBreakButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 20).isActive = true
        shortBreakButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.4).isActive = true
        shortBreakButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        shortBreakButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true

        contentView.addSubview(pomodoroButton)
        pomodoroButton.anchor(top: nil, bottom: shortBreakButton.topAnchor, leading: contentView.leadingAnchor, trailing: shortBreakButton.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 15, bottom: -10, right: 0))
        pomodoroButton.heightAnchor.constraint(equalTo: shortBreakButton.heightAnchor).isActive = true

        contentView.addSubview(longBreakButton)
        longBreakButton.anchor(top: shortBreakButton.bottomAnchor, bottom: nil, leading: contentView.leadingAnchor, trailing: shortBreakButton.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 15, bottom: 0, right: 0))
        longBreakButton.heightAnchor.constraint(equalTo: shortBreakButton.heightAnchor).isActive = true

        contentView.addSubview(dividerView)
        dividerView.anchor(top: nil, bottom: contentView.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: -20), size: .init(width: 0, height: 1))

        contentView.addSubview(pickerView)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.topAnchor.constraint(equalTo: pomodoroButton.topAnchor).isActive = true
        pickerView.bottomAnchor.constraint(equalTo: longBreakButton.bottomAnchor).isActive = true
        pickerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        pickerView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.45).isActive = true

        [shortBreakButton, pomodoroButton, longBreakButton].forEach{ $0.layer.cornerRadius = 8 }
    }
}

extension TimeCell: UIPickerViewDelegate, UIPickerViewDataSource {
    
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
        print("ccccc component \(component)")
        let selectedValue = tempArray[row]  // Get the selected value from the picker

            // Update the TimeDurationModel based on the current picker type
            switch currentPickerType {
            case .pomodoro:
                timeDurationModel.pomodoroSeconds = selectedValue
            case .shortBreak:
                timeDurationModel.shortBreakSeconds = selectedValue
            case .longBreak:
                timeDurationModel.longBreakSeconds = selectedValue
            }

        print("aaaaa in picker view time pom \(timeDurationModel.pomodoroSeconds), short \(timeDurationModel.shortBreakSeconds)")
        onDurationSelection?(timeDurationModel)
    }
}
