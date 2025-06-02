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
    
    @State private var score: Int = 0

    //Body of the Swift UI view
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
    
    //Common view - Question timer, title and divider line
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
    
    //Main content view
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

    //Method to create 4 buttons in two rows and 4 texts below them
    @ViewBuilder
    private func customButtons() -> some View {
        HStack {
            VStack {
                if let countries = currentAnswer?.countries, countries.count >= 4 {
                    HStack(spacing: 16) {
                        ForEach(0..<2, id: \.self) { index in
                            let style = getButtonStyle(for: countries[index])
                            VStack {
                                makeButtons(for: countries[index])
                                if style.showLabel {
                                    Text(style.labelText)
                                        .font(.system(size: 8, weight: .regular))
                                        .foregroundStyle(style.textColor)
                                }
                            }
                        }
                    }
                    HStack(spacing: 16) {
                        ForEach(2..<4, id: \.self) { index in
                            let style = getButtonStyle(for: countries[index])
                            VStack {
                                makeButtons(for: countries[index])
                                if style.showLabel {
                                    Text(style.labelText)
                                        .font(.system(size: 8, weight: .regular))
                                        .foregroundStyle(style.textColor)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    //Method to get button style as well as the text color/visibility
    private func getButtonStyle(for country: Country) -> (borderColor: Color,fillColor: Color,textColor: Color,showLabel: Bool,labelText: String) {
        let correctID = viewModel.getCorrectAnswer()?.id
        let isSelected = selectedCountryId == country.id
        let isCorrect = correctID == country.id

        // No selection yet return default style
        guard selectedCountryId != nil else {
            return (AppColors.buttonStroke,.clear,.clear,false,"")
        }

        // Selected and correct
        if isSelected && isAnswerCorrect == true {
            score += 1
            return (AppColors.buttonStrokeCorrect,.clear,AppColors.buttonStrokeCorrect,true,"Correct")
        }

        // Selected but wrong
        if isSelected && isAnswerCorrect == false {
            return (AppColors.titleColor,AppColors.titleColor,AppColors.titleColor,true,"Wrong")
        }

        // Not selected, but correct answer
        if !isSelected && isCorrect && isAnswerCorrect == false {
            return (AppColors.buttonStrokeCorrect,.clear,AppColors.buttonStrokeCorrect,true,"Correct")
        }

        // Default return for other buttons
        return (AppColors.buttonStroke,.clear,.clear,false,"")
    }

    //Helper Method to create the button border/fill colors based on the selection
    private func makeButtons(for country: Country) -> some View {
        let correctAnswerID = viewModel.getCorrectAnswer()?.id
        let isSelected = selectedCountryId == country.id
        let isCorrect = correctAnswerID == country.id

        // Determine border color
        let borderColor: Color
        let fillColor: Color
        var titleColor: Color = AppColors.titleColor
        
        if let _ = selectedCountryId {
            if isSelected && isAnswerCorrect == true {
                borderColor = AppColors.buttonStrokeCorrect // Correct selection
                fillColor = Color.clear
            } else if isSelected && isAnswerCorrect == false {
                borderColor = AppColors.titleColor // Wrong selection
                fillColor = AppColors.titleColor
                titleColor = .white
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
        .buttonStyle(CustomButtonStyle(borderColor: borderColor, fillColor: fillColor, titleColor: titleColor))
        
    }
    
    //Helper function to check the answer and to calculate the score
    private func handleCountrySelection(country: Country) {
        //Prevents multiple taps
        guard selectedCountryId == nil else { return }
        selectedCountryId = country.id
        let isCorrect = viewModel.checkAnswer(selectedAnswer: country.id)
        isAnswerCorrect = isCorrect
        if isCorrect {
            score += 1
        }
    }
    
    //Game over title
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
    
    //Totla score title
    private func totalScore() -> some View {
        HStack {
            Text("SCORE: ")
                .font(.system(size: 20, weight: .regular, design: .default))
                .foregroundColor(AppColors.titleColor)
            Text("\(score)/\(totalQuestions)")
                .font(.system(size: 30, weight: .semibold, design: .default))
                .foregroundColor(AppColors.buttonStroke)
        }
    }
}

#Preview {
    MainView()
}
