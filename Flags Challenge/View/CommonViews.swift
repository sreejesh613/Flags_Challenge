//
//  CommonViews.swift
//  Flags Challenge
//
//  Created by Sreejesh Krishnan on 02/06/25.
//

import SwiftUI

public func commonTitle() -> some View {
    VStack {
        VStack(alignment: .center) {
            Text("FLAGS CHALLENGE")
                .font(.system(size: 20, weight: .semibold, design: .default))
                .foregroundColor(AppColors.titleColor)
                .frame(height: 50.0, alignment: .center)
        }
        .padding(.horizontal, 10)
        Divider()
            .frame(height: 1.0)
    }
}

public func gameOver() -> some View {
    VStack(alignment: .center) {
        Text("GAME OVER")
            .font(.system(size: 35, weight: .semibold, design: .default))
            .foregroundColor(AppColors.buttonStroke)
    }
    .padding(.horizontal, 10)
}

public func totalScore() -> some View {
    VStack(alignment: .center) {
        HStack {
            Text("SCORE: ")
                .font(.system(size: 20, weight: .regular, design: .default))
                .foregroundColor(AppColors.titleColor)
        }
        Text("N/A")
            .font(.system(size: 30, weight: .semibold, design: .default))
            .foregroundColor(AppColors.buttonStroke)
    }
    .padding(.horizontal, 10)
}
