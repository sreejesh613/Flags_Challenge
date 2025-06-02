//
//  MainViewSpec.swift
//  Flags Challenge
//
//  Created by Sreejesh Krishnan on 03/06/25.
//

import Quick
import Nimble
import ViewInspector
@testable import Flags_Challenge

class MainViewSpec: QuickSpec {
    override func spec() {
        var viewModel: CountriesViewModel!
        var sut: MainView!

        beforeEach {
            viewModel = CountriesViewModel()
            sut = MainView()
            ViewHosting.host(view: sut.environmentObject(viewModel))
        }
        describe("MainView") {
            it("Should show commoniew") {
                let topStacks = try sut.inspect().vStack().zStack(0).vStack(1)
                let title = try topStacks.hStack(0).zStack(1).spacer(0).find(text: "FLAGS CHALLENGE")
                expect(title).toNot(beNil())
            }
        }
    }
}
