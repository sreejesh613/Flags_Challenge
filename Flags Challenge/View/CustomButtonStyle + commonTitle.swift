//
//  CustomButtonStyle + commonTitle.swift
//  Flags Challenge
//
//  Created by Sreejesh Krishnan on 02/06/25.
//

import SwiftUI

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

@ViewBuilder
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
