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

class TimeEntryViewSpec: QuickSpec {
    override func spec() {
        describe("TImeEntryView") {
            var viewModel: CountriesViewModel!
            var sut: TimeEntryView?

            beforeEach {
                viewModel = CountriesViewModel()
                sut = TimeEntryView()
                ViewHosting.host(view: sut?.environmentObject(viewModel))
            }
            
            it("Should find a Text") {
                let titleText = try sut?.inspect().vStack(0).zStack(0).vStack(1).find(text: "SCHEDULE")
                expect(titleText).toNot(beNil())
                let fontWeight = try titleText?.font()?.weight()
                expect(fontWeight).to(equal(.heavy))
                let topPadding = try titleText?.padding(.top)
                expect(topPadding).toNot(beNil())
            }
            it("Should find the HStack") {
                let topVstack = try sut?.inspect().vStack(0).zStack(0).vStack(1)
                expect(topVstack).toNot(beNil())
                let hStack = try topVstack?.hStack(0)
                let hhText = try hStack?.find(text: "HH")
                expect(hhText).toNot(beNil())
                let keyboardType = try hhText?.keyboardType()
                expect(keyboardType).to(equal(.numberPad))
            }
            it("Should find a button") {
                let topVstack = try sut?.inspect().vStack(0).zStack(0).vStack(1)
                let saveButton = try topVstack?.button(0)
                let savebutton = try saveButton?.find(text: "Save")
                expect(saveButton).toNot(beNil())
                let foregroundColor = try saveButton?.foregroundColor()
                expect(foregroundColor) == Color.white
            }
            it("Should find the main countdown timer") {
                let topVstack = try sut?.inspect().vStack(0).zStack(0).vStack(1)
                let saveButton = try topVstack?.button(0)
                let savebutton = try saveButton?.find(text: "Save")
                expect(saveButton).toNot(beNil())
                //Simulate a tap
                _ = try saveButton?.tap()
            }
        }
    }
}
