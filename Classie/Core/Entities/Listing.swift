//
//  Listing.swift
//  Classie
//
//  Created by Ilia Gutu on 15.01.2022.
//

import Foundation

struct Listing {
    let name: String
    let price: String
    let uid: String
    let createdAt: String
    let images: [Image]

    struct Image {
        let url: URL
    }
}

extension Listing: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case price
        case uid
        case createdAt = "created_at"
        case images = "image_urls"
    }
}

extension Listing.Image: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let url = try container.decode(URL.self)
        self.init(url: url)
    }
}
