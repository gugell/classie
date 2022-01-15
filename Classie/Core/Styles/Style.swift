//
//  Style.swift
//  Classie
//
//  Created by Ilia Gutu on 16.01.2022.
//

import UIKit

protocol StyleApplicable where Self: UIView { }
extension UIView: StyleApplicable { }

extension StyleApplicable {
    public func apply(style: Style<Self>?) {
        style?.apply(to: self)
    }
}

struct Style<T: StyleApplicable> {
    let style: (T) -> Void

    func apply(to applicable: T) { style(applicable) }
}
