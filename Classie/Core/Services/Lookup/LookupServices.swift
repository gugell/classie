//
//  LookupServices.swift
//  Classie
//
//  Created by Ilia Gutu on 15.01.2022.
//

import Combine
import Foundation
import Moya

protocol LookupService {
    func fetchListings(completionHandler: @escaping  (Result<[Listing], LookupServiceError>) -> Void)
}

public enum LookupServiceError: Error {
    case failure(Error)
    case badResponse
    case reason(String)

    var localizedDescription: String {
        switch self {
        case .badResponse:
            return "Bad response from server"
        case .failure(let error):
            return error.localizedDescription
        case .reason(let message):
            return message
        }
    }

    var errorDescription: String? {
        return localizedDescription
    }
}

final class LookupServiceImpl: LookupService {
    private let provider: MoyaProvider<LookupServiceEndpoints>

    init(provider: MoyaProvider<LookupServiceEndpoints> = _MoyaProvider.of(ofType: LookupServiceEndpoints.self, stubBehaviour: .immediate)) {
        self.provider = provider
    }

    func fetchListings(completionHandler: @escaping  (Result<[Listing], LookupServiceError>) -> Void) {
        provider.request(.listings,
                         arrayOfType: Listing.self,
                         path: "results") { returnData in
            completionHandler(.success(returnData))
        } failure: { error in
            completionHandler(.failure(LookupServiceError.failure(error)))
        }
    }
}
