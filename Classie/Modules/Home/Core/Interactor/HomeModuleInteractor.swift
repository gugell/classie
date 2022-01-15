//
//  HomeModuleInteractor.swift
//  Classie
//
//  Created by Ilia Gutu on 15.01.2022.
//

import Foundation

/// Modules interactor input
protocol HomeModuleInteractorInput: AnyObject {
  /// Reload listings from server
  func reloadData()
}

/// Modules interactor output
protocol HomeModuleInteractorOutput: AnyObject {
  /// Notifies that interactor finished loading listings
    func interactorDidFinishLoading(_ listings: [Listing])
    func interactorDidFailWithError(_ error: String)
}

final class HomeModuleInteractor: HomeModuleInteractorInput {
    
    weak var output: HomeModuleInteractorOutput!
    private let lookupService: LookupService
    
    init(lookupService: LookupService) {
        self.lookupService = lookupService
    }
    
    func reloadData() {
        lookupService.fetchListings { [weak self] result in
            switch result {
            case .success(let listings):
                self?.output?.interactorDidFinishLoading(listings)
            case .failure(let error):
                self?.output?.interactorDidFailWithError(error.localizedDescription)
            }
        }
    }
}
