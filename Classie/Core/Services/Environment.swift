//
//  Environment.swift
//  Classie
//
//  Created by Ilia Gutu on 15.01.2022.
//

import Foundation

public struct Environment {

    static let current = Environment()

    let lookupService: LookupService
    let baseURL: URL

    init(lookupService: LookupService = LookupServiceImpl(),
         baseURL: URL = URL(string: "https://ey3f2y0nre.execute-api.us-east-1.amazonaws.com/default")!) {
        self.baseURL = baseURL
        self.lookupService = lookupService
    }
}
