//
//  ImageRandomizer.swift
//  Classie
//
//  Created by Ilia Gutu on 15.01.2022.
//

import UIKit

enum Picsum {
    struct Image: Codable {
        let id: String
        let url: URL
    }

    enum Generator {
        static func randomImages(with size: CGSize = .init(width: 300, height: 400)) -> [URL] {
            guard let url = Bundle.main.url(forResource: "picsum",
                                            withExtension: "json"),
                  let data = try? Data(contentsOf: url),
                  let contents = try? JSONDecoder().decode([Image].self, from: data)
            else { return [] }

            return (1...10)
                .map { _ in Int.random(in: 0..<contents.count - 1) }
                .compactMap { URL(string: "https://picsum.photos/id/\($0)/\(Int(size.width))/\(Int(size.height))") }
        }
    }
}
