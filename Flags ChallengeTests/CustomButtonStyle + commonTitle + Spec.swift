//
//  Untitled.swift
//  Flags Challenge
//
//  Created by Sreejesh Krishnan on 03/06/25.
//
import Quick
import Nimble
import ViewInspector
import SwiftUI
@testable import Flags_Challenge

class CustomButtonStyleSpec: QuickSpec {
    override func spec() {
        var subject: CustomButtonStyle!
        beforeEach {
            subject = CustomButtonStyle(
                borderColor: AppColors.buttonStroke,
                fillColor: AppColors.titleColor,
                titleColor: AppColors.buttonTitle
            )
        }
        describe("Tests CustomButtonStyle struct") {
            it("Checks border color") {
                let borderColor = subject.borderColor
                expect(borderColor).toNot(beNil())
                expect(borderColor) == AppColors.buttonStroke
            }
            it("Checks title color") {
                let titleColor = subject.titleColor
                expect(titleColor).toNot(beNil())
                expect(titleColor) == AppColors.buttonTitle
            }
        }
    }
}
