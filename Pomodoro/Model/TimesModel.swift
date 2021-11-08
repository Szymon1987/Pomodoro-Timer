//
//  TimesModel.swift
//  Pomodoro
//
//  Created by Szymon Tadrzak on 27/10/2021.
//

import UIKit

//struct TimesModel {
//    
//    let
//    
//}


import UIKit

class ViewController: UIViewController {

  enum IntervalType {
    case Pomodoro
    case RestBreak
  }
  let intervals: [IntervalType] = [.Pomodoro,
                                   .RestBreak,
                                   .Pomodoro,
                                   .RestBreak,
                                   .Pomodoro,
                                   .RestBreak,
                                   .Pomodoro]
  var currentInterval = 0

  // Interval lengths and time remaining
  // -----------------------------------
  // For testing purposes, I made the lengths of the pomodoro and rest break intervals
  // 20 seconds and 5 seconds, respectively. For the actual versions, use the
  // commented lengths.
  let pomodoroIntervalTime = 20 // Actual length: 25 * 60
  let restBreakIntervalTime = 5 // Actual length:  5 * 60
  var timeRemaining = 0

  // Timer
  // -----
  // The heart of the app.
  var myTimer = Timer()

  // UI controls
  // -----------
  @IBOutlet weak var minutesLabel: UILabel!
  @IBOutlet weak var secondsLabel: UILabel!
  @IBOutlet weak var intervalLabel: UILabel!
  @IBOutlet var tomatoIcons: [UIImageView]!
  @IBOutlet weak var startPauseButton: UIButton!
  @IBOutlet weak var resetButton: UIButton!


  override func viewDidLoad() {
    super.viewDidLoad()

    resetToBeginning()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func resetToBeginning() {
    currentInterval = 0
    setTomatoMeter(to: 1)
    intervalLabel.text = "Ready to work!"
    startPauseButton.setTitle("Start", for: .normal)
    resetButton.isEnabled = false
    timeRemaining = pomodoroIntervalTime
    updateDisplay()
  }

  @IBAction func startPauseButtonPressed(_ sender: UIButton) {
    if myTimer.isValid {
      // If the timer is currently running:
      //   1. Change the button’s title to “Resume”
      //   2. Enable the rest button
      //   3. Pause the timer
      startPauseButton.setTitle("Resume", for: .normal)
      resetButton.isEnabled = true
      pauseTimer()
    } else {
      // If the timer is currently stopped:
      //   1. Change the button’s title to “Pause”
      //   2. Disable the Reset button
      startPauseButton.setTitle("Pause", for: .normal)
      resetButton.isEnabled = false
      if currentInterval == 0 && timeRemaining == pomodoroIntervalTime {
        // If we’re currently at the very start of a set of pomodori (plural for pomodoro),
        // begin the cycle of intervals.
        startNextInterval()
      } else {
        // If we're in the middle of a set of pomodori,
        // simply resume the timer.
        startTimer()
      }
    }
  }

  @IBAction func resetButtonPressed(_ sender: UIButton) {
    if myTimer.isValid {
      // The timer shouldn’t be running if the Reset button is enabled,
      // but let’s make sure it’s stopped, just in case.
      myTimer.invalidate()
    }
    resetToBeginning()
  }

  func startNextInterval() {
    if currentInterval < intervals.count {
      // If we haven’t done all the intervals yet,
      // do the next one.
      if intervals[currentInterval] == .Pomodoro {
        // Pomodoro interval
        timeRemaining = pomodoroIntervalTime
        intervalLabel.text = "Pomodoro!"
        let tomatoes = (currentInterval + 2) / 2
        print("\(tomatoes) tomatoes")
        setTomatoMeter(to: tomatoes)
      } else {
        // Rest break interval
        timeRemaining = restBreakIntervalTime
        intervalLabel.text = "Rest break."
      }
      updateDisplay()
      startTimer()
      currentInterval += 1
    } else {
      // If we’ve done all the intervals,
      // reset the app.
      resetToBeginning()
    }
  }

  func updateDisplay() {
    let (minutes, seconds) = minutesAndSeconds(from: timeRemaining)
    minutesLabel.text = formatMinuteOrSecond(minutes)
    secondsLabel.text = formatMinuteOrSecond(seconds)
  }

  // Start the timer, which will call the timerTick() method every second.
  func startTimer() {
    myTimer = Timer.scheduledTimer(timeInterval: 1,
                                   target: self,
                                   selector: #selector(timerTick),
                                   userInfo: nil,
                                   repeats: true)
  }

    @objc func timerTick() {
    if timeRemaining > 0 {
      timeRemaining -= 1
      print("time: \(timeRemaining)")
      updateDisplay()
    } else {
      myTimer.invalidate()
      startNextInterval()
    }
  }

  func pauseTimer() {
    myTimer.invalidate()
    intervalLabel.text = "Paused."
  }

  func setTomatoMeter(to tomatoes: Int) {
    var currentTomato = 1
    for tomatoIcon in tomatoIcons {
      tomatoIcon.alpha = currentTomato <= tomatoes ? 1.0 : 0.2
      currentTomato += 1
    }
  }

  // Given a number of seconds, return it as (minutes, seconds).
  func minutesAndSeconds(from seconds: Int) -> (Int, Int) {
    return (seconds / 60, seconds % 60)
  }

  // Given a number, return it as a string of 2 digits,
  // with a leading zero if necessary.
  func formatMinuteOrSecond(_ number: Int) -> String {
    return String(format: "%02d", number)
  }

}
