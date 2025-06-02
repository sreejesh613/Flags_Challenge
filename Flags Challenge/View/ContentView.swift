//
//  ContentView.swift
//  Flags Challenge
//
//  Created by Sreejesh Krishnan on 16/05/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel:  CountriesViewModel

    @StateObject private var timerViewModel = TimerViewModel()
    @State private var totalQuestions: Int = 0
    @State private var currentAnswer: Answer?
    @State private var currentIndex: Int = 0
    @State private var isGameOver = false
    
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    HStack {
                        ZStack(alignment: .center) {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.black)
                                .frame(width: 80.0, height: 50.0)
                            Text("\(timerViewModel.formattedQuestionTimer)")
                                .font(.system(size: 20, weight: .semibold, design: .default))
                                .foregroundStyle(Color.white)
                        }
                        Spacer()
                        commonTitle()
                            .frame(maxWidth: .infinity, alignment: .center)
                        Spacer()
                    }
                    .padding(.top, 20.0)
                    .padding(.horizontal, 10)
                    Spacer()

                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.black)
                                .frame(width: 50.0, height: 35.0)
                            Circle()
                                .fill(AppColors.titleColor)
                                .frame(width: 35.0, height: 35.0)
                            Text("\(currentIndex)" + "/" +  "\(totalQuestions)")
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
            viewModel.loadQuestions()
        }
        .onChange(of: timerViewModel.isTimerInvalidated) { _, newValue in
            if newValue {
                viewModel.nextAnswer()
                currentAnswer = viewModel.currentAnswer
                currentIndex = viewModel.currentCountryIndex

                timerViewModel.startTimer(duration: 2)
            }
        }
        .onChange(of: viewModel.isGameOver) { _, gameOver in
            if gameOver {
                timerViewModel.stopTimer()
            }
        }
        .onReceive(viewModel.$countries.compactMap { $0 }) { countries in
            totalQuestions =  countries.questions.count
            viewModel.currentCountryIndex = 0
            viewModel.nextAnswer()
            currentIndex = viewModel.currentCountryIndex
            currentAnswer = viewModel.currentAnswer
            
            timerViewModel.startTimer(duration: 2)
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
            .foregroundColor(AppColors.buttonTitle)
            .opacity(configuration.isPressed ? 0.7 : 1)
            .scaleEffect(configuration.isPressed ? 0.8 : 1)
            .frame(maxWidth: .infinity, maxHeight: 32.0)
            .overlay {
                RoundedRectangle(cornerRadius: 8.0)
                    .stroke(AppColors.buttonStroke)
            }
    }
}

#Preview {
    ContentView()
}
