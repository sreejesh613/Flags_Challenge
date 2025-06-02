//
//  CountriesViewModel.swift
//  Flags Challenge
//
//  Created by Sreejesh Krishnan on 20/05/25.
//

import Foundation

class CountriesViewModel: ObservableObject {
    @Published var countries: Questions? {
        didSet {
            totalQuestions = countries?.questions.count ?? 0
        }
    }
    @Published var totalQuestions: Int = 0
    @Published var currentCountryIndex = 0
    @Published var isGameOver = false
    
    var currentAnswer: Answer? {
        guard let questions = countries?.questions, questions.indices.contains(currentCountryIndex) else { return nil }
        return countries?.questions[currentCountryIndex]
    }
    
    func loadQuestions() {
        countries = JsonLoader.loadCountries()!
        currentCountryIndex = 0
    }
    
    func nextAnswer() {
        if currentCountryIndex < (countries?.questions.count ?? 0) - 1 {
            currentCountryIndex += 1
        } else {
            isGameOver = true
        }
    }
    
    //Check the anser - user input on the button
    func checkAnswer(selectedAnswer: Int) -> Bool {
        // Check if the selected country ID matches the correct answer ID
        guard let currentQuestion = countries?.questions.first(where: { question in
            question.countries.contains(where: { $0.id == selectedAnswer })
        }) else {
            return false
        }
        
        // Return true if the selected country ID matches the answer_id
        return currentQuestion.answer_id == selectedAnswer
    }
    
    //Helper method to show the correct answer - Highlight the button
    func getCorrectAnswer() -> Country? {
        guard let currentQuestion = getCurrentQuestion() else { return nil }
        return currentQuestion.countries.first { $0.id == currentQuestion.answer_id }
    }
    
    func getCurrentQuestion() -> Answer? {
        // Assuming you have a way to get the current question
        // This depends on your specific implementation
        return countries?.questions[currentCountryIndex]
    }
}
