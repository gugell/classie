//
//  ApplicationFlowService.swift
//  Classie
//
//  Created by Ilia Gutu on 15.01.2022.
//

import UIKit

final class ApplicationFlowService: NSObject, ApplicationService {

    var rootNavigationController: UINavigationController {
        return window?.rootViewController as? UINavigationController  ?? UINavigationController()
    }

    private lazy var appCoordinator: ApplicationCoordinator = {
        let wireframe = DefaultWireframe(rootController: rootNavigationController)
        let coordinator = ApplicationCoordinator(wireframe: wireframe)
        return coordinator
    }()

    func application(_ application: UIApplication, // swiftlint:disable:next line_length
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        debugPrint("🎉 ApplicationFlowService has started!")

        if #available(iOS 15.0, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithDefaultBackground()
            navigationBarAppearance.titleTextAttributes = [
                .foregroundColor: Colors.black(),
                .font: UIFont.systemFont(ofSize: 18, weight: .semibold)
            ]

            let appearance = UINavigationBar.appearance()
            appearance.tintColor  = Colors.black()
            appearance.standardAppearance = navigationBarAppearance
            appearance.compactAppearance = navigationBarAppearance
            appearance.scrollEdgeAppearance = navigationBarAppearance
        }

        window?.makeKeyAndVisible()
        appCoordinator.start()

        return true
    }
}

extension ApplicationService {
    public var window: UIWindow? {
        return UIApplication.shared.delegate?.window ?? nil
    }
}
