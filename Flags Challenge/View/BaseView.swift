//
//  BaseView.swift
//  Flags Challenge
//
//  Created by Sreejesh Krishnan on 30/05/25.
//
import SwiftUI

struct BaseView: ViewModifier {
    func body(content: Content) -> some View {
        content
        RoundedRectangle(cornerRadius: 16)
            .fill(AppColors.baseViewBackground)
            .allowsHitTesting(false)
    }
}

extension View {
    func applyBaseViewStyle() -> some View {
        self.modifier(BaseView())
    }
}

public func commonTitle() -> some View {
    VStack {
        VStack(alignment: .center) {
            Text("FLAGS CHALLENGE")
                .font(.system(size: 20, weight: .semibold, design: .default))
                .foregroundColor(AppColors.titleColor)
        }
        .padding(.horizontal, 10)
        Divider()
            .frame(height: 1.0)
    }
}
