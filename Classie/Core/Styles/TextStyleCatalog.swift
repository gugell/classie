//
//  TextStyleCatalog.swift
//  Classie
//
//  Created by Ilia Gutu on 16.01.2022.
//

import UIKit

enum TextStyles {
    static let title = Style<UILabel> {
        $0.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        $0.textColor = Colors.black()
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }

    static let subtitle = Style<UILabel> {
        $0.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        $0.textColor = Colors.gray()
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }

    static let attribute = Style<UILabel> {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        $0.textColor = Colors.black()
        $0.textAlignment = .right
        $0.numberOfLines = 0
    }
}
