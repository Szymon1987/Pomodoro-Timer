import UIKit

struct Presentable {
    
    enum ThemeType {
        case font
        case color
    }
    
    let title: String?
    let buttonConfig: [ButtonConfig]
    let type: ThemeType
    
    struct ButtonConfig {
        let title: String?
        let backgroundcolor: UIColor
        let image: UIImage?
        let font: UIFont?
        let textColor: UIColor?
    }
}

protocol SettingsViewControllerDelegate: AnyObject {
    func settingsViewControllerDidUpdateFromSettings(settingsModel: SettingsModel)
}

final class SettingsViewController: UIViewController {
    
    private var settingsModel: SettingsModel = .default
    private let coordinator: AppCoordinator
    
    weak var delegate: SettingsViewControllerDelegate?

    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        print("SettingsViewController is deinited")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var tableView: UITableView = {
        let tb = UITableView()
        tb.dataSource = self
        tb.delegate = self
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.isScrollEnabled = false
        return tb
    }()
    
    private lazy var xmarkButton: ReusableButton = {
        let button = ReusableButton(systemImageName: "xmark")
        button.tintColor = .systemGray
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    private lazy var applyButton: ReusableButton = {
        let button = ReusableButton(title: "Apply", fontType: .boldFont(size: 22), textColor: .white, backgroundColor: .pomodoroOrange)
        button.addTarget(self, action: #selector(applyButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        setupViews()
    }

    private func registerCells() {
        tableView.register(UITableViewCell.self)
        tableView.register(AppearanceCell.self)
        tableView.register(TimeCell.self)
    }
    
    @objc private func handleDismiss() {
        Haptics.light()
        self.dismiss(animated: true)
    }
    
    @objc private func applyButtonTapped() {
        Haptics.light()
        self.dismiss(animated: true) { [weak self] in
            self?.delegate?.settingsViewControllerDidUpdateFromSettings(settingsModel: self?.settingsModel ?? .default)
        }
    }
    
    private func setupViews() {
        
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        tableView.setRoundedCorner(withRadius: 15)
        
        view.addSubview(xmarkButton)
        xmarkButton.topAnchor.constraint(equalTo: tableView.topAnchor, constant: 25).isActive = true
        xmarkButton.trailingAnchor.constraint(equalTo: tableView.trailingAnchor, constant: -25).isActive = true
        xmarkButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        xmarkButton.widthAnchor.constraint(equalTo: xmarkButton.heightAnchor).isActive = true
        
        view.addSubview(applyButton)
        applyButton.widthAnchor.constraint(equalTo: tableView.widthAnchor, multiplier: 0.40).isActive = true
        applyButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        applyButton.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        applyButton.centerYAnchor.constraint(equalTo: tableView.bottomAnchor).isActive = true
        applyButton.setRoundedCorner(withRadius: 25)
    }
    
    private func updateColor(color: UIColor?) {
        applyButton.backgroundColor = color
    }
}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = switchCells(for: indexPath)
        cell.selectionStyle = .none
        return cell
    }
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        getCellHeight(for: indexPath.row)
//        return UITableView.automaticDimension
    }
    
}

private extension SettingsViewController {
    
    // MARK: - Helper Functions
    
    func getCellHeight(for raw: Int) -> CGFloat {
        let tableViewHeight = tableView.frame.size.height
        switch raw {
        case 0:
            return tableViewHeight * 0.15
        case 1:
            return tableViewHeight * 0.35
        case 2:
            return tableViewHeight * 0.25
        case 3:
            return tableViewHeight * 0.25
        default:
            return 100
        }
    }
    
    func switchCells(for indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
//        cell.selectionStyle = .none
        
        let checkmarkImage = UIImage(systemName: "checkmark")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        
        let fontPresentable = Presentable(title: "FONT", buttonConfig: [
            Presentable.ButtonConfig(title: "Aa", backgroundcolor: .black, image: nil, font: nil, textColor: .white),
            Presentable.ButtonConfig(title: "Aa", backgroundcolor: .backgroundGray, image: nil, font: .italicFont(size: 16), textColor: .black),
            Presentable.ButtonConfig(title: "Aa", backgroundcolor: .backgroundGray, image: nil, font: .boldFont(size: 16), textColor: .black)
        ], type: .font)

        let colorPresentable = Presentable(title: "COLOR", buttonConfig: [
            Presentable.ButtonConfig(title: nil, backgroundcolor: .pomodoroOrange, image: checkmarkImage, font: nil, textColor: nil),
            Presentable.ButtonConfig(title: nil, backgroundcolor: .pomodoroBlue, image: nil, font: nil, textColor: nil),
            Presentable.ButtonConfig(title: nil, backgroundcolor: .pomodoroPurple, image: nil, font: nil, textColor: nil),
        ], type: .color)
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(UITableViewCell.self)!
            cell.textLabel?.text = "Settings"
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(TimeCell.self)!
            cell.onDurationSelection = { [weak self] times in
                print("bbbbb times \(times)")
                self?.settingsModel.timeDurationModel = times
                
            }
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(AppearanceCell.self)!
            cell.configure(presentable: fontPresentable)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(AppearanceCell.self)!
            cell.configure(presentable: colorPresentable)
            cell.updateColorAndFont = { [weak self] color, font in
                self?.updateColor(color: color)
                self?.settingsModel.appearanceModel.color = color ?? .red
                self?.settingsModel.appearanceModel.font = font ?? .normalFont(size: 16)
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(UITableViewCell.self)!
            cell.textLabel?.text = "Settings"
            return cell
        }
    }
}
