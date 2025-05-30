//
//  TimeEntryView.swift
//  Flags Challenge
//
//  Created by Sreejesh Krishnan on 20/05/25.
//

import SwiftUI
import AEOTPTextField

struct TimeEntryView: View {
    @State private var time: String = ""
    @StateObject private var timeEntryViewModel = TimeEntryViewModel()
    @State private var startCountdown: Bool = false

    var body: some View {
        VStack {
            ZStack(alignment: .center) {
                if startCountdown {
                    VStack(spacing: 20.0) {
                        commonTitle()
                        countDownTimer()
                    }
                    .applyBaseViewStyle()
                } else {
                    VStack {
                        commonTitle()
                        Text("SCHEDULE")
                            .fontWeight(.heavy)
                            .bold()
                            .border(.black)
                            .padding(.top, 10)
                        HStack(spacing: 10.0) {
                            TextField("HH", text: $timeEntryViewModel.hours)
                                .keyboardType(.numberPad)
                                .frame(width: 50.0)
                                .textFieldStyle(.roundedBorder)
                            Text(":")
                            TextField("MM", text: $timeEntryViewModel.minutes)
                                .keyboardType(.numberPad)
                                .frame(width: 50.0)
                                .textFieldStyle(.roundedBorder)
                            Text(":")
                            TextField("SS", text: $timeEntryViewModel.seconds)
                                .keyboardType(.numberPad)
                                .frame(width: 50.0)
                                .textFieldStyle(.roundedBorder)
                        }
                        Button(action: {
                            dump("Save button pressed!")
                            startCountdown = true
                            timeEntryViewModel.startTimer()
                        }) { Text("Save")
                                .frame(width: 110.0, height: 35.0)
                                .background(Color.orange)
                                .foregroundStyle(Color.white)
                                .cornerRadius(7.0)
                        }
                    }
                    .applyBaseViewStyle()
                }
            }
            .frame(width: .infinity, height: 270)
            .padding(.horizontal, 5.0)
            Spacer()
        }
    }
    
    private func commonTitle() -> some View {
        VStack {
            VStack(alignment: .center) {
                Text("FLAGS CHALLENGE")
                    .foregroundStyle(.red)
                    .fontWeight(.heavy)
                    .bold()
            }
            .padding(.horizontal, 10)
            Divider()
                .frame(height: 1.0)
        }
    }
    
    private func countDownTimer() -> some View {
        VStack {
            Text("CHALLENGE")
                .font(.system(size: 18.0, weight: .semibold))
                .padding(.bottom, 10)
            Text("WILL START IN")
                .font(.system(size: 24, weight: .semibold))
                .padding(.bottom, 15)
            Text(timeEntryViewModel.formattedTime)
                .font(.system(size: 28.0, weight: .semibold))
                .foregroundStyle(Color(red: 120.0/255.0, green: 120.0/255.0, blue: 120.0/255.0, opacity: 1.0))
        }
    }
}

#Preview {
    TimeEntryView()
}
