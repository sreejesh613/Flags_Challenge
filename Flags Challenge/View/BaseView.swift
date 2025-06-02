//
//  BaseView.swift
//  Flags Challenge
//
//  Created by Sreejesh Krishnan on 30/05/25.
//
import SwiftUI

//Background view - reusable
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
