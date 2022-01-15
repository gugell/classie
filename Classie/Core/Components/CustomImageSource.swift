//
//  CustomImageSource.swift
//  Classie
//
//  Created by Ilia Gutu on 15.01.2022.
//
import UIKit
import ImageSlideshow

/// Input Source to image using Kingfisher
public class CustomImageSource: NSObject, InputSource {
    /// url to load
    public var url: URL

    /// placeholder used before image is loaded
    public var placeholder: UIImage?

    private let imageLoader = ImageFetcher()

    /// Initializes a new source with a URL
    /// - parameter url: a url to be loaded
    /// - parameter placeholder: a placeholder used before image is loaded
    /// - parameter options: options for displaying
    public init(url: URL, placeholder: UIImage? = nil) {
        self.url = url
        self.placeholder = placeholder
        super.init()
    }

    /// Load an image to an UIImageView
    ///
    /// - Parameters:
    ///   - imageView: UIImageView that receives the loaded image
    ///   - callback: Completion callback with an optional image
    @objc
    public func load(to imageView: UIImageView, with callback: @escaping (UIImage?) -> Void) {
        imageView.image = self.placeholder
        Task.init {
            do {
                let image = try await imageLoader.fetch(url)
                UI { callback(image) }
            } catch {
                UI { callback(self.placeholder) }
            }
        }
    }

    /// Cancel an image download task
    ///
    /// - Parameter imageView: UIImage view with the download task that should be canceled
    public func cancelLoad(on imageView: UIImageView) {
        Task.init {
            await imageLoader.cancelTask(for: url)
        }
    }
}
