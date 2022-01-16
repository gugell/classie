//
//  LookupServiceTests.swift
//  ClassieTests
//
//  Created by Ilia Gutu on 16.01.2022.
//
@testable import Classie
import XCTest
import Nimble
import Moya

final class LookupServiceTests: XCTestCase {

    var lookupService: LookupService!

    func test_fetchListings_whenFailed_shouldSendCorrespondingErrorMessage() {
        // GIVEN
        let stubbedError = "Something wrong happened"
        lookupService = createSUT(stubbedError)
        // WHEN
        lookupService.fetchListings { result in
            // THEN
            if case .failure(let error) = result {
                expect(error.localizedDescription).to(equal(stubbedError))
                return
            }

            fail("Should return error")
        }
    }

    func test_fetchListings_whenSucceded_shouldReturnStubbedData() {
        // GIVEN
        let stubItems = [Listing.mocked(name: "Item 1"),
                         .mocked(name: "Item 2")]
        do {
            let data = try JSONEncoder().encode(["results": stubItems])
            lookupService = createSUT(mockData: data)

            // WHEN
            lookupService.fetchListings { result in

                // THEN
                if case .success(let items) = result {
                    expect(items).toEventually(equal(stubItems))
                    return
                }

                fail("Should return items")
            }
        } catch {
            fail(error.localizedDescription)
        }
    }

    private func createSUT(_ errorMessage: String? = nil, mockData: Data? = nil) -> LookupServiceImpl {
        let statusCode = errorMessage == nil ? 200 : 404
        let provider = MockMoyaProvider.mocked(ofType: LookupServiceEndpoints.self,
                                               responseTime: 0,
                                               statusCode: statusCode,
                                               mockData: mockData ?? Data(),
                                               errorMessage: errorMessage)
        return LookupServiceImpl(provider: provider)
    }
}
