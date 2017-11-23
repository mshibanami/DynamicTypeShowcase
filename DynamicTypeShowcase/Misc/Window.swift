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
        // HACK:
        // traitCollection should NOT be overridden.
        // ref: https://developer.apple.com/documentation/uikit/uitraitenvironment/1623514-traitcollection
        // But I couldn't find any idea to disable Dynamic Type for an app...
        // And it looks work fine for me. 🤤

        var traits = [
            super.traitCollection
        ]

        if !UserDefaults.standard.isEnableGlobalSizeCategory {
            traits.append(UITraitCollection(
                preferredContentSizeCategory: .large))
        }

        let tc = UITraitCollection(traitsFrom: traits)
        return tc
    }
}
