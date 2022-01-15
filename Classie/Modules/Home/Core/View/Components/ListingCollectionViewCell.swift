//
//  ListingCollectionViewCell.swift
//  Classie
//
//  Created by Ilia Gutu on 15.01.2022.
//

import UIKit
import Reusable
import ImageSlideshow
import VanillaConstraints

final class ListingCollectionViewCell: UICollectionViewCell, Reusable, BindableType {
    var viewModel: ListingCollectionViewCellViewModel!

    private let imageCarouselView: ImageSlideshow = {
        let view = ImageSlideshow()
        view.contentScaleMode = .scaleAspectFill
        return view
    }()

    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let dateLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    private func setupUI() {
        imageCarouselView.add(to: self)
            .top(to: \.topAnchor)
            .left(to: \.leftAnchor)
            .right(to: \.rightAnchor)

        titleLabel.add(to: self)
            .top(to: \.bottomAnchor, of: imageCarouselView, constant: 20)
            .leading(to: \.leadingAnchor, constant: 10)

        priceLabel.add(to: self)
            .leading(to: \.trailingAnchor, of: titleLabel, constant: 20)
            .trailing(to: \.trailingAnchor, constant: 10)
            .centerY(to: \.centerYAnchor, of: titleLabel)

        dateLabel.add(to: self)
            .top(to: \.bottomAnchor, of: titleLabel, constant: 10)
            .leading(to: \.leadingAnchor, constant: 10)
            .trailing(to: \.trailingAnchor, constant: 10)
            .bottom(to: \.bottomAnchor, constant: 20)

        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textColor = Colors.black()

        priceLabel.numberOfLines = 0
        priceLabel.textAlignment = .right
        priceLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        priceLabel.textColor = Colors.black()

        dateLabel.numberOfLines = 0
        dateLabel.textAlignment = .left
        dateLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        dateLabel.textColor = Colors.gray()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bindViewModel() {
        titleLabel.text = viewModel.name
        priceLabel.text = viewModel.price
        dateLabel.text = viewModel.createdAt
        let inputs = viewModel.images.map { KingfisherSource(url: $0, placeholder: Assets.defaultPlaceholder())}

        //TODO: - Remove this logic once multiple images will be available for any of the items
        let mocksImages = Array(repeating: inputs, count: Int.random(in: 1..<10)).flatMap { $0 }
        imageCarouselView.setImageInputs(mocksImages)
    }
}


struct ListingCollectionViewCellViewModel: Hashable {
    let name: String
    let price: String
    let createdAt: String
    let uid: String
    let images: [URL]
}

extension ListingCollectionViewCellViewModel {
    init(listing: Listing) {
        self.name = listing.name
        self.uid = listing.uid
        self.price = listing.price
        self.images = listing.images.map { $0.url }
        self.createdAt = listing.createdAt
    }
}
