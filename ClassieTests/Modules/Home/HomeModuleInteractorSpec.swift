//
//  HomeModuleInteractorTests.swift
//  ClassieTests
//
//  Created by Ilia Gutu on 15.01.2022.
//

import Quick
import Nimble

@testable import Moya
@testable import Classie

final class HomeModuleInteractorSpec: QuickSpec {
    override func spec() {
        var interactor: HomeModuleInteractor!
        var lookupService: MockLookupService!
        var output: MockHomeInteractorOutput!

        beforeEach {
            lookupService = MockLookupService()
            output = MockHomeInteractorOutput()
            interactor = HomeModuleInteractor(lookupService: lookupService)
            interactor.output = output
        }

        it("returns stubbed data for lookup request") {
            // GIVEN
            let expectedResponse = [Listing.mocked()]
            lookupService.fetchListingsStub = .success(expectedResponse)

            // WHEN
            interactor.reloadData()

            // THEN
            expect(output.interactorDidFinishLoadingFuncCheck.wasCalled).to(beTrue())
        }

        it("returns an error for lookup") {
            // GIVEN
            let expectedErrorMessage = "Something went wrong"
            lookupService.fetchListingsStub = .failure(.reason(expectedErrorMessage))

            // WHEN
            interactor.reloadData()

            // THEN
            expect(output.interactorDidFailWithErrorFuncCheck.wasCalled(with: expectedErrorMessage)).to(beTrue())
        }
    }
}
