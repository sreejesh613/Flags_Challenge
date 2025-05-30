//
//  ContentView.swift
//  Flags Challenge
//
//  Created by Sreejesh Krishnan on 16/05/25.
//

import SwiftUI

struct ContentView: View {
    @State var timeRemaining = 10
    @StateObject private var questionsViewModel = CountriesViewModel()
    @State private var totalQuestions: Int = 0
    @State private var currentQuestion = 0
    @State private var isTimerInvalidated = false
    @State private var currentAnswer: Answer?
    @State private var isTImerRunning = false
    
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    HStack(alignment: .center) {
                        let timer = Timer.publish(
                            every: 1,
                            on: .main,
                            in: .common)
                            .autoconnect()
                        Text("\(timeRemaining)")
                            .onReceive(timer) { _ in
                                isTImerRunning = true
                                if timeRemaining > 0 {
                                    print("timer running")
                                    timeRemaining -= 1
                                    print("\(timeRemaining)")
                                } else {
                                    timer.upstream.connect().cancel()
                                    isTimerInvalidated = true
                                    isTImerRunning = false
                                }
                            }
                        Spacer()
                        Text("FLAGS CHALLENGE")
                        Spacer()
                    }
                    .padding(.top, 20.0)
                    .padding(.horizontal, 10)
                    Divider()
                        .frame(height: 1.0)
                    Spacer()
                    
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.black)
                                .frame(width: 50.0, height: 35.0)
                            Circle()
                                .fill(Color(red: 255/255.0, green: 112/255.0, blue: 67/255.0, opacity: 1.0))
                                .frame(width: 35.0, height: 35.0)
                            Text("\(currentQuestion)" + "/" +  "\(totalQuestions)")
                                .foregroundStyle(.white)
                        }
                        Spacer()
                        Text("GUESS THE COUNTRY FROM THE FLAG?")
                        Spacer()
                    }
                    HStack {
                        ZStack {
                            Image("\(currentAnswer?.answer_id ?? 113)")
                                .frame(width: 72.0, height: 58.0)
                                .applyBaseViewStyle()
                                .frame(width: 120.0, height: 90.0)
                        }
                        Spacer()
                        customButtons()
                    }
                    .padding()
                    Spacer()
                }
                .applyBaseViewStyle()
            }
            .frame(width: .infinity, height: 270)
            .padding(.horizontal, 5.0)
        }
        .onAppear {
            questionsViewModel.loadQuestions()
            if isTimerInvalidated || !isTImerRunning {
                questionsViewModel.nextAnswer()
                currentAnswer = questionsViewModel.currentAnswer
            }
        }
        .onChange(of: isTimerInvalidated) { oldValue, newValue in
            if newValue {
                questionsViewModel.nextAnswer()
                currentAnswer = questionsViewModel.currentAnswer
            }
        }
        .onReceive(questionsViewModel.$countries.compactMap { $0 }) { countries in
            totalQuestions =  countries.questions.count
            currentQuestion = 1
            print("Total questions: \(totalQuestions)")
        }
        Spacer()
    }

    private func customButtons() -> some View {
        HStack {
            VStack {
                if let countries = currentAnswer?.countries, countries.count >= 4 {
                    VStack(spacing: 16) {
                        HStack(spacing: 16) {
                            ForEach(0..<2, id: \.self) { index in
                                Button(action: {
                                    //Button action
                                }) {
                                    Text(countries[index].country_name)
                                }
                                .buttonStyle(CustomButtonStyle())
                            }
                        }
                        HStack(spacing: 16) {
                            ForEach(2..<4, id: \.self) { index in
                                Button(action: {
                                    //Button action
                                }) {
                                    Text(countries[index].country_name)
                                }
                                .buttonStyle(CustomButtonStyle())
                            }
                        }
                    }
                }
            }
        }
    }
}

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        return configuration.label
            .padding()
            .foregroundColor(Color(red: 58/255, green: 58/255, blue: 58/255, opacity: 1))
            .opacity(configuration.isPressed ? 0.7 : 1)
            .scaleEffect(configuration.isPressed ? 0.8 : 1)
            .frame(maxWidth: .infinity, maxHeight: 32.0)
            .overlay {
                RoundedRectangle(cornerRadius: 8.0)
                    .stroke(Color(red: 72/255, green: 72/255, blue: 72/255, opacity: 1))
            }
    }
}

#Preview {
    ContentView()
}
