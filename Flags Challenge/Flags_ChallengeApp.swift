//
//  Flags_ChallengeApp.swift
//  Flags Challenge
//
//  Created by Sreejesh Krishnan on 16/05/25.
//

import SwiftUI

@main
struct Flags_ChallengeApp: App {
    @StateObject var viewModel = CountriesViewModel()

    var body: some Scene {
        WindowGroup {
            TimeEntryView()
                .environmentObject(viewModel)
        }
    }
}
