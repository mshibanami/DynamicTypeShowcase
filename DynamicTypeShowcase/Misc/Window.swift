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
        var traits = [
            super.traitCollection
        ]

        if UserDefaults.standard.isEnableGlobalSizeCategory {
            traits.append(UITraitCollection(
                preferredContentSizeCategory: .large))
        }

        /// HACK: traitCollection should NOT be overridden:
        /// https://developer.apple.com/documentation/uikit/uitraitenvironment/1623514-traitcollection
        /// But I couldn't find any idea to disable Dynamic Type for a app.
        let tc = UITraitCollection.init(traitsFrom: [
            super.traitCollection
            ])
        return tc
    }
}
