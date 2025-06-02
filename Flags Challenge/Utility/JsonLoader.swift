//
//  JsonLoader.swift
//  Flags Challenge
//
//  Created by Sreejesh Krishnan on 20/05/25.
//

import Foundation

//Helper method to load the json file/data from the bundle
class JsonLoader {
    static func loadCountries() -> Questions? {
        guard let url = Bundle.main.url(forResource: "countries", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let countries = try? JSONDecoder().decode(Questions.self, from: data) else {
            print("Failed to load countries.json")
            return nil
        }
        return countries
    }
}
