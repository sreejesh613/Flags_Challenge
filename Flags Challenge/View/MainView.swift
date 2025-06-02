//
//  ContentView.swift
//  Flags Challenge
//
//  Created by Sreejesh Krishnan on 16/05/25.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewModel:  CountriesViewModel
    
    @StateObject private var timerViewModel = TimerViewModel()
    @State private var totalQuestions: Int = 0
    @State private var currentAnswer: Answer?
    @State private var currentIndex: Int = 0
    @State private var index = 0
    @State private var showScoreCard = false

    var body: some View {
        VStack {
            ZStack {
                VStack {
                    if showScoreCard {
                        commonView()
                        totalScore()
                    } else if viewModel.isGameOver {
                        commonView()
                        gameOver()
                    } else {
                        commonView()
                        contentView()
                    }
                }
                .applyBaseViewStyle()
            }
            .frame(width: .infinity, height: 270)
            .padding(.horizontal, 5.0)
        }
        .onAppear {
            viewModel.loadQuestions()
        }
        .onChange(of: viewModel.isGameOver) { _, gameOver in
            if gameOver {
                timerViewModel.resetTimer()
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                    showScoreCard = true
                }
            }
        }
        .onChange(of: timerViewModel.isTimerInvalidated) { _, newValue in
            currentAnswer = viewModel.currentAnswer
            currentIndex = viewModel.currentCountryIndex
            index = currentIndex
            if newValue && !viewModel.isGameOver {
                viewModel.nextAnswer()
                timerViewModel.startTimer(duration: 1)
            }
        }
        .onReceive(viewModel.$countries.compactMap { $0 }) { countries in
            totalQuestions =  countries.questions.count
            viewModel.currentCountryIndex = 0
//            viewModel.nextAnswer()
            currentIndex = viewModel.currentCountryIndex
            currentAnswer = viewModel.currentAnswer
            
            timerViewModel.startTimer(duration: 1)
        }
        Spacer()
    }
    
    @ViewBuilder private func commonView() -> some View {
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
    }
    
    @ViewBuilder private func contentView() -> some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.black)
                    .frame(width: 50.0, height: 37.0)
                Circle()
                    .fill(AppColors.titleColor)
                    .frame(width: 35.0, height: 35.0)
                Text("\(index + 1)" + "/" +  "\(totalQuestions)")
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

    @ViewBuilder
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
    
    @ViewBuilder
    private func gameOver() -> some View {
        VStack(alignment: .center) {
            Text("GAME OVER")
                .font(.system(size: 35, weight: .semibold, design: .default))
                .foregroundColor(AppColors.buttonStroke)
        }
        .padding(.horizontal, 10)
        Spacer()
    }
    
    @ViewBuilder
    private func totalScore() -> some View {
        HStack {
            Text("SCORE: ")
                .font(.system(size: 20, weight: .regular, design: .default))
                .foregroundColor(AppColors.titleColor)
            Text("N/A")
                .font(.system(size: 30, weight: .semibold, design: .default))
                .foregroundColor(AppColors.buttonStroke)
        }
        Spacer()
    }
}

#Preview {
    MainView()
}
