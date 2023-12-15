import UIKit

final class ClockView: UIView {
    
    struct Constants {
        static let start = "START"
        static let stop = "STOP"
    }
    
    private lazy var clockLabel: ReusableLabel = {
        let label = ReusableLabel(fontSize: 54, textColor: .white)
        label.text = "00:00"
        return label
    }()
    
    private let startStopButton: ReusableButton = {
        let button = ReusableButton(
            title: Constants.start,
            fontType: .normalFont(size: 22),
            textColor: .white)
        return button
    }()
    
    var startStopButtonTapped: ((Bool) -> Void)?

    public let circleShapeLayer = CAShapeLayer()

    func allCyclesFinished(pomodoroTime: String) {
        startStopButton.setTitle(Constants.start, for: .normal)
        clockLabel.text = pomodoroTime
    }
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .darkPurple
        setupViews()
        setupShapeLayer()
        configureStartStopButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureStartStopButton() {
        startStopButton.setTitle(Constants.start, for: .normal)
        startStopButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        startStopButton.titleLabel?.setTextSpacingBy(value: 10)
    }
    
    @objc private func buttonTapped() {
        var isRunning: Bool = false
        if startStopButton.titleLabel?.text == Constants.start {
            startStopButton.setTitle(Constants.stop, for: .normal)
            isRunning = true
        } else {
            isRunning = false
            startStopButton.setTitle(Constants.start, for: .normal)
        }
        self.startStopButton.titleLabel?.setTextSpacingBy(value: 10)
        startStopButtonTapped?(isRunning)
    }
    
    func updateTimeLabel(timeString: String) {
        clockLabel.text = timeString
        print( "time stirng \(timeString)")
    }
    
    //MARK: - View Setup
    
    private func setupViews() {
        
        addSubview(clockLabel)
        clockLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10).isActive = true
        clockLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        addSubview(startStopButton)
        startStopButton.topAnchor.constraint(equalTo: clockLabel.bottomAnchor, constant: 17).isActive = true
        startStopButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        startStopButton.leadingAnchor.constraint(equalTo: clockLabel.leadingAnchor).isActive = true
        startStopButton.trailingAnchor.constraint(equalTo: clockLabel.trailingAnchor).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.frame.height / 2
        
        let center = CGPoint(x: layer.bounds.midX, y: layer.bounds.midY)
       
        let radius = (self.frame.height - 35) / 2
        let circularPath = UIBezierPath(arcCenter: .zero, radius: radius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        circleShapeLayer.position = center
        circleShapeLayer.path = circularPath.cgPath
        
        // if startAngle isn't set to 0 there is a bug in animation. CircleShapeLayer is rotated 90 degree
        circleShapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
    }
    
    private func setupShapeLayer() {
        
        circleShapeLayer.strokeColor = UIColor.pomodoroOrange.cgColor
        circleShapeLayer.lineWidth = 10
        circleShapeLayer.lineCap = .round
        circleShapeLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(circleShapeLayer)

    }
}
