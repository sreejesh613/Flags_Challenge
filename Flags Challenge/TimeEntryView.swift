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
    @State private var navPath = NavigationPath()
    @StateObject private var timeEntryViewModel = TimeEntryViewModel()

    var body: some View {
        VStack {
            NavigationStack(path: $navPath) {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(
                            red: 217/255.0,
                            green: 217/255.0,
                            blue: 217/255.0,
                            opacity: 0.3
                        ))
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
                            navPath.append(Screen.secondScreen)
                        }) { Text("Save")
                                .frame(width: 110.0, height: 35.0)
                                .background(Color.orange)
                                .foregroundStyle(Color.white)
                                .cornerRadius(7.0)
                        }
                    }
                    .navigationDestination(for: Screen.self) { screen in
                        switch screen {
                        case .secondScreen:
                            ContentView()
                        }
                    }
                }
                .frame(width: .infinity, height: 250)
                Spacer()
            }
        }
    }
}

#Preview {
    TimeEntryView()
}
