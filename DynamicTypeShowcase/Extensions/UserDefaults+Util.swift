//
//  Setting.swift
//  DynamicTypeShowcase
//
//  Created by abc on 2017/11/23.
//  Copyright © 2017 mshibanami. All rights reserved.
//

import UIKit

extension UserDefaults {
    private struct Key {
        static let isEnableGlobalSizeCategory = "isEnableGlobalSizeCategory"
    }

    var isEnableGlobalSizeCategory: Bool {
        get {
            UserDefaults.standard.register(
                defaults: [
                    Key.isEnableGlobalSizeCategory: true
                ])
            return UserDefaults.standard
                .bool(forKey: Key.isEnableGlobalSizeCategory)
        }

        set {
            UserDefaults.standard
                .set(newValue, forKey: Key.isEnableGlobalSizeCategory)
        }
    }
}
