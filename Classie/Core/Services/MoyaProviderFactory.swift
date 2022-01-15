//
//  MoyaProviderFactory.swift
//  Classie
//
//  Created by Ilia Gutu on 15.01.2022.
//

import Foundation
import Moya

enum _MoyaProvider {
    static func of<Target: TargetType>(ofType type: Target.Type,
                                       stubBehaviour: Moya.StubBehavior = .never) -> MoyaProvider<Target> {
        return MoyaProvider<Target>(stubClosure: {_ in stubBehaviour },
                                    plugins: [
            NetworkLoggerPlugin.verbose,
        ])
    }
}
