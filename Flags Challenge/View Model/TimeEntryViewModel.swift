//
//  TimeEntryViewModel.swift
//  Flags Challenge
//
//  Created by Sreejesh Krishnan on 30/05/25.
//
import SwiftUI

class TimeEntryViewModel: ObservableObject {
    @Published var hours = ""
    @Published var minutes = ""
    @Published var seconds = ""
    @Published var timeRemaining: Int = 0
    @Published var isTimerRunning = false
    @Published var isTimerInvalidated = false
    
    private var timer: Timer?
    
    var formattedTime: String {
        let hrs = timeRemaining/3600
        let mins = (timeRemaining % 3600)/60
        let secs = timeRemaining % 60
        return String(format: "%02d:%02d:%02d", hrs, mins, secs)
    }
    
    func startTimer() {
        guard !isTimerRunning else { return }
        let hr = Int(hours) ?? 0
        let mn = Int(minutes) ?? 0
        let sc = Int(seconds) ?? 0
        
        timeRemaining = hr * 3600 + mn * 60 + sc
        
        guard timeRemaining > 0 else { return }
        
        isTimerRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.stopTimer()
            }
        })
        
    }
    
    func stopTimer() {
        guard isTimerRunning else { return }
        isTimerRunning = false
        timer?.invalidate()
        isTimerInvalidated = true
        timer = nil
    }
    
    func ResetTimer() {
        stopTimer()
        timeRemaining = 0
    }
}
