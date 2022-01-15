//
//  MockHomeInteractorOutput.swift
//  ClassieTests
//
//  Created by Ilia Gutu on 15.01.2022.
//

@testable import Classie

final class MockHomeInteractorOutput: HomeModuleInteractorOutput {

    let interactorDidFinishLoadingFuncCheck = FuncCheck<[Listing]>()
    func interactorDidFinishLoading(_ listings: [Listing]) {
        interactorDidFinishLoadingFuncCheck.call(listings)
    }

    let interactorDidFailWithErrorFuncCheck = FuncCheck<String>()
    func interactorDidFailWithError(_ error: String) {
        interactorDidFailWithErrorFuncCheck.call(error)
    }
}
