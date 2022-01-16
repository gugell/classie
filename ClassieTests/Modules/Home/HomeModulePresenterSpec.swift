//
//  HomeModulePresenterTests.swift
//  ClassieTests
//
//  Created by Ilia Gutu on 15.01.2022.
//

import Quick
import Nimble

@testable import Moya
@testable import Classie

final class HomeModulePresenterSpec: QuickSpec {
    override func spec() {
        var presenter: HomeModulePresenter!
        var mockView: MockHomeViewInput!
        var interactor: MockHomeModuleInteractorInput!
        var router: MockHomeModuleRouterInput!

        beforeEach {
            mockView = MockHomeViewInput()
            router = MockHomeModuleRouterInput()
            interactor = MockHomeModuleInteractorInput()
            presenter = HomeModulePresenter(view: mockView,
                                            interactor: interactor,
                                            router: router)
        }

        it("when reloadData is triggered should show HUD and start fetching data") {
            // GIVEN
            // WHEN
            presenter.reloadData()

            // THEN
            expect(mockView.showHUDFuncCheck.wasCalled).to(beTrue())
            expect(interactor.reloadDataFuncCheck.wasCalled).to(beTrue())
        }

        it("when selects an item should redirect to listing details") {
            // GIVEN
            // WHEN
            presenter.interactorDidFinishLoading([.mocked(name: "Item1"), .mocked(name: "Item2")])
            presenter.didSelectItem(at: .init(item: 1, section: 0))

            // THEN
            expect(router.showListingDetailsFuncCheck.wasCalled(with: .mocked(name: "Item2"))).to(beTrue())
        }
    }
}
