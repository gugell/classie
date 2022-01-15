//
//  MockLookupService.swift
//  ClassieTests
//
//  Created by Ilia Gutu on 15.01.2022.
//

import Classie

final class MockLookupService: LookupService {

    var fetchListingsStub: Result<[Listing], LookupServiceError> = .success([])

    func fetchListings(completionHandler: @escaping (Result<[Listing], LookupServiceError>) -> Void) {
        completionHandler(fetchListingsStub)
    }
}
