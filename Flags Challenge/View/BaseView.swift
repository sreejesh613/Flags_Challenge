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
            .fill(Color(
                red: 217/255.0,
                green: 217/255.0,
                blue: 217/255.0,
                opacity: 0.3
            ))
            .allowsHitTesting(false)
    }
}

extension View {
    func applyBaseViewStyle() -> some View {
        self.modifier(BaseView())
    }
}
