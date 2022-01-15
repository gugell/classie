//
//  MockListing.swift
//  ClassieTests
//
//  Created by Ilia Gutu on 16.01.2022.
//

import Classie
import Foundation

extension Listing {
    static func mocked(name: String = "An Item",
                       price: String = "USD 100",
                       uid: String = "xxxxx",
                       createdAt: String = "TODAY",
                       placeholderURL: URL = URL(string: "https://google.com")!) -> Listing {
        return Listing(name: name,
                            price: price,
                            uid: uid,
                            createdAt: createdAt,
                       images: [.init(url: placeholderURL)])
    }
}
