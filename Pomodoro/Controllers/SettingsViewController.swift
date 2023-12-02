//
//  SettingsViewController.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 26/04/2022.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    private let appearanceModel: AppearanceModel
    private let coordinator: AppCoordinator
    
    private let timeDurationModel = TimeDurationModel()
    
    // DUMMY DATA READY TO BE SEND
    
    /// TimeDurationModel
    let pom: Int = 9
    let short : Int = 3
    let long: Int = 6
    
    /// AppearanceModel
    let color: UIColor = .purple
    let font: UIFont = .normalFont(size: 16)

    init(appearanceModel: AppearanceModel, coordinator: AppCoordinator) {
        self.appearanceModel = appearanceModel
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
        // UITableView extension methods
        tableView.register(UITableViewCell.self)
        tableView.register(ColorCell.self)
        tableView.register(FontCell.self)
    }
    
    @objc private func handleDismiss() {
        Haptics.light()
        self.dismiss(animated: true)
    }
    
    @objc private func applyButtonTapped() {
        Haptics.light()
        self.dismiss(animated: true)
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
    }
    
}

extension SettingsViewController {
    
    // MARK: - Helper Functions
    
    func getCellHeight(for raw: Int) -> CGFloat {
        let tableViewHeight = tableView.frame.height
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
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(UITableViewCell.self)!
            cell.textLabel?.text = "Settings"
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(UITableViewCell.self)!
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(FontCell.self)!
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(ColorCell.self)!
            return cell
        default:
            let cell = tableView.dequeueReusableCell(UITableViewCell.self)!
            cell.textLabel?.text = "Settings"
            return cell
        }
    }
}

