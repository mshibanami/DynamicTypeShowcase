//
//  UIContentSizeCategory+Enum.swift
//  DynamicTypeShowcase
//
//  Created by abc on 2017/07/23.
//  Copyright © 2017 mshibanami. All rights reserved.
//

import UIKit

extension UIContentSizeCategory {
    /// The name of the enum value
    public var name: String {
        switch self {
        case .unspecified:
            return "unspecified"
        case .extraSmall:
            return "XSmall"
        case .small:
            return "small"
        case .medium:
            return "medium"
        case .large:
            return "large"
        case .extraLarge:
            return "XLarge"
        case .extraExtraLarge:
            return "XXLarge"
        case .extraExtraExtraLarge:
            return "XXXLarge"
        case .accessibilityMedium:
            return "accessibilityMedium"
        case .accessibilityLarge:
            return "accessibilityLarge"
        case .accessibilityExtraLarge:
            return "accessibilityXLarge"
        case .accessibilityExtraExtraLarge:
            return "accessibilityXXLarge"
        case .accessibilityExtraExtraExtraLarge:
            return "accessibilityXXXLarge"
        default:
            return "🤔"
        }
    }
}
