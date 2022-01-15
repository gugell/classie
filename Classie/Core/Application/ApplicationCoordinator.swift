//
//  ApplicationCoordinator.swift
//  Classie
//
//  Created by Ilia Gutu on 15.01.2022.
//

import UIKit

final class ApplicationCoordinator: BaseCoordinator {

    private let wireframe: Wireframe

    init(wireframe: Wireframe) {
        self.wireframe = wireframe
        super.init()
    }

    override func start(with option: DeepLinkOption) {
        // start with deepLink
        if option != .unknown {
            childCoordinators.forEach { coordinator in
                coordinator.start(with: option)
            }
        } else {
            runMainFlow()
        }
    }

    private func runMainFlow() {
        let coordinator = HomeFlowCoordinator(wireframe: wireframe)
        addDependency(coordinator)
        coordinator.start()
    }
}
