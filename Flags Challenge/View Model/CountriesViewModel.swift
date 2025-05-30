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
            currentCountryIndex = 0
        }
    }
    
    func checkAnswer(selectedAnswer: Int) -> Answer? {
        countries?.questions.first(where: { question in
            question.countries.contains(where: { $0.id == selectedAnswer })
        })
    }
}
