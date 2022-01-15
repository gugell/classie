//
//  MockHomeModuleRouterInput.swift
//  ClassieTests
//
//  Created by Ilia Gutu on 15.01.2022.
//

@testable import Classie

final class MockHomeModuleRouterInput: HomeModuleRouterInput {

    let showListingDetailsFuncCheck = FuncCheck<Listing>()
    func showListingDetails(_ listing: Listing) {
        showListingDetailsFuncCheck.call(listing)
    }

    let showErrorAlertFuncCheck = FuncCheck<String>()
    func showErrorAlert(_ error: String, onRetry: @escaping EmptyAction) {
        showErrorAlertFuncCheck.call(error)
    }
}
