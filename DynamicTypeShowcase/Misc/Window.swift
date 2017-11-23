//
//  Application.swift
//  DynamicTypeShowcase
//
//  Created by abc on 2017/11/22.
//  Copyright © 2017 mshibanami. All rights reserved.
//

import UIKit

class Window: UIWindow {
    override var traitCollection: UITraitCollection {
        let tc = UITraitCollection.init(traitsFrom: [
            super.traitCollection,
            UITraitCollection(
                preferredContentSizeCategory: .large)
            ])
        return tc
    }
}
