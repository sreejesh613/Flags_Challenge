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
    
    @State private var selectedCountryId: Int?
    @State private var isAnswerCorrect: Bool?

    var body: some View {
        VStack {
            ZStack {
                VStack {
                    if showScoreCard {
                        commonView()
                        Spacer()
                        totalScore()
                        Spacer()
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
                selectedCountryId = nil
                isAnswerCorrect = nil
                timerViewModel.startTimer(duration: 10)
            }
        }
        .onReceive(viewModel.$countries.compactMap { $0 }) { countries in
            totalQuestions =  countries.questions.count
            viewModel.currentCountryIndex = 0
//            viewModel.nextAnswer()
            currentIndex = viewModel.currentCountryIndex
            currentAnswer = viewModel.currentAnswer
            
            timerViewModel.startTimer(duration: 10)
        }
        Spacer()
    }
    
    private func commonView() -> some View {
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
    }
    
    @ViewBuilder
    private func contentView() -> some View {
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
                    HStack(spacing: 16) {
                        ForEach(0..<2, id: \.self) { index in
                            VStack {
                                makeButtons(for: countries[index])
                                Text("Correct")
                                    .font(.system(size:6, weight: .regular, design: .default))
                            }
                        }
                    }
                    HStack(spacing: 16) {
                        ForEach(2..<4, id: \.self) { index in
                            VStack {
                                makeButtons(for: countries[index])
                                Text("Correct")
                                    .font(.system(size: 6, weight: .regular, design: .default))
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func makeButtons(for country: Country) -> some View {
        let correctAnswerID = viewModel.getCorrectAnswer()?.id
        let isSelected = selectedCountryId == country.id
        let isCorrect = correctAnswerID == country.id

        // Determine border color
        let borderColor: Color
        let fillColor: Color
        if let selected = selectedCountryId {
            if isSelected && isAnswerCorrect == true {
                borderColor = AppColors.buttonStrokeCorrect // Correct selection
                fillColor = Color.clear
            } else if isSelected && isAnswerCorrect == false {
                borderColor = AppColors.titleColor // Wrong selection
                fillColor = Color.green
            } else if !isSelected && isCorrect && isAnswerCorrect == false {
                borderColor = AppColors.buttonStrokeCorrect // Show correct answer after wrong selection
                fillColor = Color.clear
            } else {
                borderColor = AppColors.buttonStroke
                fillColor = Color.clear
            }
        } else {
            borderColor = AppColors.buttonStroke
            fillColor = Color.clear
        }

        return Button(action: {
            handleCountrySelection(country: country)
        }) {
            Text(country.country_name)
        }
        .buttonStyle(CustomButtonStyle(borderColor: borderColor, fillColor: fillColor))
    }
    
    private func handleCountrySelection(country: Country) {
        selectedCountryId = country.id
        isAnswerCorrect = viewModel.checkAnswer(selectedAnswer: country.id)
    }
    
    private func gameOver() -> some View {
        VStack(alignment: .center) {
            Spacer()
            Text("GAME OVER")
                .font(.system(size: 35, weight: .semibold, design: .default))
                .foregroundColor(AppColors.buttonStroke)
            Spacer()
        }
        .padding(.horizontal, 10)
    }
    
    private func totalScore() -> some View {
        HStack {
            Text("SCORE: ")
                .font(.system(size: 20, weight: .regular, design: .default))
                .foregroundColor(AppColors.titleColor)
            Text("N/A")
                .font(.system(size: 30, weight: .semibold, design: .default))
                .foregroundColor(AppColors.buttonStroke)
        }
    }
}

#Preview {
    MainView()
}
