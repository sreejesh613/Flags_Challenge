//
//  TimerViewModel.swift
//  Flags Challenge
//
//  Created by Sreejesh Krishnan on 31/05/25.
//
import SwiftUI

class TimerViewModel: ObservableObject {
    @Published var timeRemaining: Int = 0
    @Published var isTimerInvalidated = false
    
    @Published var hours = ""
    @Published var minutes = ""
    @Published var seconds = ""
    
    var timer: Timer?
    var isTimerRunning = false
    
    var formattedTime: String {
        let hrs = timeRemaining/3600
        let mins = (timeRemaining % 3600)/60
        let secs = timeRemaining % 60
        return String(format: "%02d:%02d:%02d", hrs, mins, secs)
    }
    
    var formattedQuestionTimer: String {
        let mins = (timeRemaining % 3600)/60
        let secs = timeRemaining % 60
        return String(format: "%02d:%02d", mins, secs)
    }
    
    func startCountDownTimerFromInput() {
        let hrs = Int(hours) ?? 0
        let mns = Int(minutes) ?? 0
        let sec = Int(seconds) ?? 0
        
        let total = (hrs * 3600) + (mns * 60) + sec
        startTimer(duration: total)
    }
    
    func startTimer(duration: Int) {
        timeRemaining = duration
        timer?.invalidate()
        isTimerInvalidated = false

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            isTimerRunning = true

            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                stopTimer()
                self.isTimerInvalidated = true
            }
        }
    }
    
    func stopTimer() {
        guard timer != nil else { return }
        timer?.invalidate()
        timer = nil
        isTimerRunning = false
    }
}
