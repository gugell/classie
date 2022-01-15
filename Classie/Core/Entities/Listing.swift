//
//  Listing.swift
//  Classie
//
//  Created by Ilia Gutu on 15.01.2022.
//

import Foundation

public struct Listing: Codable, Equatable {
    let name: String
    let price: String
    let uid: String
    let createdAt: String
    let images: [Image]

    enum CodingKeys: String, CodingKey {
        case name
        case price
        case uid
        case createdAt = "created_at"
        case images = "image_urls"
    }

    public init(name: String, price: String, uid: String, createdAt: String, images: [Image]) {
        self.name = name
        self.price = price
        self.uid = uid
        self.createdAt = createdAt
        self.images = images
    }

    public struct Image: Codable {
        let url: URL

        public init(url: URL) {
            self.url = url
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let url = try container.decode(URL.self)
            self.init(url: url)
        }
    }

    public static func == (lhs: Listing, rhs: Listing) -> Bool {
        return lhs.uid == rhs.uid && lhs.name == rhs.name
    }

}
