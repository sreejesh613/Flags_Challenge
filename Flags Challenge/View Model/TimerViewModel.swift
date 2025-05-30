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
    
    func startTimer(_ duration: Int) {
        timeRemaining = duration
        isTimerInvalidated = false
        isTimerRunning = true
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
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
    
    func resetTimer() {
        stopTimer()
        timer?.invalidate()
        isTimerRunning = false
    }
    
    func totalTimeDurationInSeconds(_ time: String) -> Int {
        let components = time.split(separator: ":")
        guard components.count == 3 else { return 0 }
        
        let hours = components[0]
        let minutes = components[1]
        let seconds = components[2]
        
        guard let hr = Int(hours) else { return 0 }
        let hr1 = hr * 60 * 60
        guard let mn = Int(minutes) else { return 0 }
        let mn1 = mn * 60
        guard let sc = Int(seconds) else { return 0 }
        
        return hr1 + mn1 + sc
    }
}
