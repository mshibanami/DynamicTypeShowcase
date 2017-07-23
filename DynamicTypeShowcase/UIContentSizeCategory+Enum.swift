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
    /// See Also: https://developer.apple.com/ios/human-interface-guidelines/visual-design/typography/
    public var name: String {
        switch self {
        case .unspecified:
            return "unspecified"
        case .extraSmall:
            return "xsmall"
        case .small:
            return "Small"
        case .medium:
            return "Medium"
        case .large:
            return "Large"
        case .extraLarge:
            return "xLarge"
        case .extraExtraLarge:
            return "xxLarge"
        case .extraExtraExtraLarge:
            return "xxxLarge"
        case .accessibilityMedium:
            return "AX1"
        case .accessibilityLarge:
            return "AX2"
        case .accessibilityExtraLarge:
            return "AX3"
        case .accessibilityExtraExtraLarge:
            return "AX4"
        case .accessibilityExtraExtraExtraLarge:
            return "AX5"
        default:
            return "🤔"
        }
    }
}
