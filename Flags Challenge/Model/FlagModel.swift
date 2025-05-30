//
//  FlagModel.swift
//  Flags Challenge
//
//  Created by Sreejesh Krishnan on 16/05/25.
//

import Foundation

struct Questions: Decodable {
    let questions: [Answer]
}

struct Answer: Decodable {
    let answer_id: Int
    let countries: [Country]
    let country_code: String
}

struct Country: Decodable {
    let id: Int
    let country_name: String
}
