//
//  UIContentSizeCategory+Enum.swift
//  DynamicTypeShowcase
//
//  Created by abc on 2017/07/23.
//  Copyright © 2017 mshibanami. All rights reserved.
//

import UIKit

extension UIContentSizeCategory {

    /**
     * Valid UIContentSizeCategories.
     * `.unspecified` isn't included in this.
     */
    public static var validSizes: [(value: UIContentSizeCategory, name: String)] {
        let s: [(value: UIContentSizeCategory, name: String)] = [
            (.extraSmall, "XSmall"),
            (.small, "Small"),
            (.medium, "Medium"),
            (.large, "Large"),
            (.extraLarge, "XLarge"),
            (.extraExtraLarge, "XXLarge"),
            (.extraExtraExtraLarge, "XXXLarge"),
            (.accessibilityMedium, "AX1"),
            (.accessibilityLarge, "AX2"),
            (.accessibilityExtraLarge, "AX3"),
            (.accessibilityExtraExtraLarge, "AX4"),
            (.accessibilityExtraExtraExtraLarge, "AX5") ]
        return s
    }

    /// The name of the enum value
    /// See Also: https://developer.apple.com/ios/human-interface-guidelines/visual-design/typography/
    public var name: String {
        let size = UIContentSizeCategory
            .validSizes
            .filter({ $0.value == self })
            .first

        if let n = size?.name {
            return n
        } else {
            return "🤔"
        }
    }

    public var isDefault: Bool {
        return self == .large
    }

}
