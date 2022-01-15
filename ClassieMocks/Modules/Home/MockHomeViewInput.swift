//
//  MockHomeViewInput.swift
//  ClassieTests
//
//  Created by Ilia Gutu on 15.01.2022.
//

@testable import Classie
import UIKit

final class MockHomeViewInput: HomeModuleViewInput {

    let setupInitialStateFuncCheck = ZeroArgumentsFuncCheck()
    func setupInitialState() {
        setupInitialStateFuncCheck.call()
    }

    let endRefreshingFuncCheck = ZeroArgumentsFuncCheck()
    func endRefreshing() {
        endRefreshingFuncCheck.call()
    }

    let applySnapshotFuncCheck = ZeroArgumentsFuncCheck()
    func applySnapshot(snapshot: Snapshot) {
        applySnapshotFuncCheck.call()
    }

    let showEmptyViewFuncCheck = ZeroArgumentsFuncCheck()
    func showEmptyView() {
        showEmptyViewFuncCheck.call()
    }

    let showHUDFuncCheck = ZeroArgumentsFuncCheck()
    func showHUD() {
        showHUDFuncCheck.call()
    }

    let hideHUDFuncCheck = ZeroArgumentsFuncCheck()
    func hideHUD() {
        hideHUDFuncCheck.call()
    }

    var viewControllerToPresentStub: UIViewController?
    func toPresent() -> UIViewController? {
        return viewControllerToPresentStub
    }
}
