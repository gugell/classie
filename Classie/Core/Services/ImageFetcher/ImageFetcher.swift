//
//  ImageFetcher.swift
//  Classie
//
//  Created by Ilia Gutu on 15.01.2022.
//

import UIKit

enum ImageFetchError: Error {
    case failure(Error)
    case badData

    var localizedDescription: String {
        switch self {
        case .badData:
            return "Bad image data"
        case .failure(let error):
            return error.localizedDescription
        }
    }

    var errorDescription: String? {
        return localizedDescription
    }
}

actor ImageFetcher {
    private var images: [URLRequest: LoaderStatus] = [:]

    public func fetch(_ url: URL) async throws -> UIImage {
        let request = URLRequest(url: url)
        return try await fetch(request)
    }

    public func cancelTask(for url: URL) {
        let request = URLRequest(url: url)
        if case .inProgress(let task) = images[request] {
            task.cancel()
        }
    }

    public func fetch(_ urlRequest: URLRequest) async throws -> UIImage {
        if let status = images[urlRequest] {
            switch status {
            case .fetched(let image):
                return image
            case .inProgress(let task):
                return try await task.value
            }
        }

        if let image = try? imageFromFileSystem(for: urlRequest) {
            images[urlRequest] = .fetched(image)
            return image
        }

        let task: Task<UIImage, Error> = Task {
            let (imageData, _) = try await URLSession.shared.data(for: urlRequest)
            if let image = UIImage(data: imageData) {
                try? self.persistImage(image, for: urlRequest)
                return image
            }
            throw ImageFetchError.badData
        }

        images[urlRequest] = .inProgress(task)

        let image = try await task.value

        images[urlRequest] = .fetched(image)

        return image
    }

    private func imageFromFileSystem(for urlRequest: URLRequest) throws -> UIImage? {
        guard let url = fileName(for: urlRequest) else {
            assertionFailure("Unable to generate a local path for \(urlRequest)")
            return nil
        }

        let data = try Data(contentsOf: url)
        return UIImage(data: data)
    }

    private func fileName(for urlRequest: URLRequest) -> URL? {
        guard let fileName = urlRequest.url?
                .absoluteString
                .addingPercentEncoding(withAllowedCharacters: .urlPathAllowed),
              let applicationSupport = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
                  return nil
              }

        return applicationSupport.appendingPathComponent(fileName)
    }

    private func persistImage(_ image: UIImage, for urlRequest: URLRequest) throws {
        guard let url = fileName(for: urlRequest),
              let data = image.jpegData(compressionQuality: 0.8) else {
            assertionFailure("Unable to generate a local path for \(urlRequest)")
            return
        }

        try data.write(to: url)
    }

    private enum LoaderStatus {
        case inProgress(Task<UIImage, Error>)
        case fetched(UIImage)
    }
}
