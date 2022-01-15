//
//  MockHomeModuleInteractorInput.swift
//  ClassieTests
//
//  Created by Ilia Gutu on 15.01.2022.
//

@testable import Classie

final class MockHomeModuleInteractorInput: HomeModuleInteractorInput {

    let reloadDataFuncCheck = ZeroArgumentsFuncCheck()
    func reloadData() {
        reloadDataFuncCheck.call()
    }
}
