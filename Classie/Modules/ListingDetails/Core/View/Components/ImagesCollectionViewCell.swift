//
//  ImagesCollectionViewCell.swift
//  Classie
//
//  Created by Ilia Gutu on 15.01.2022.
//

import UIKit
import ImageSlideshow
import Reusable
import VanillaConstraints

final class ImagesCollectionViewCell: UITableViewCell, Reusable, BindableType {

    var viewModel: ImagesCellViewModel!

    private let imageCarouselView: ImageSlideshow = {
        let view = ImageSlideshow()
        view.contentScaleMode = .scaleAspectFill
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        imageCarouselView.add(to: contentView)
            .pinToEdges()
            .height(400, relation: .equalOrGreater)
    }

    func bindViewModel() {
        let images = viewModel.images + Picsum.Generator.randomImages()
        // TODO: - Remove this logic once multiple images will be available for any of the items
        let mocksImages = images.map { CustomImageSource(url: $0, placeholder: Assets.defaultPlaceholder())}
        imageCarouselView.setImageInputs(mocksImages)
    }
}

struct ImagesCellViewModel {
    let images: [URL]
}
