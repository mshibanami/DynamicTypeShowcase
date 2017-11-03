//
//  UIContentSizeCategory+Enum.swift
//  DynamicTypeShowcase
//
//  Created by abc on 2017/07/23.
//  Copyright © 2017 mshibanami. All rights reserved.
//

import UIKit

extension UIContentSizeCategory {
    
    public static var sizes: [(value: UIContentSizeCategory, name: String)]  {
        var s: [(value: UIContentSizeCategory, name: String)] = [
            (.extraSmall, "xsmall"),
            (.small, "Small"),
            (.medium, "Medium"),
            (.large, "Large"),
            (.extraLarge, "xLarge"),
            (.extraExtraLarge, "xxLarge"),
            (.extraExtraExtraLarge, "xxxLarge"),
            (.accessibilityMedium, "AX1"),
            (.accessibilityLarge, "AX2"),
            (.accessibilityExtraLarge, "AX3"),
            (.accessibilityExtraExtraLarge, "AX4"),
            (.accessibilityExtraExtraExtraLarge, "AX5"),]
        
        if #available(iOS 10.0, *) {
            s.append((.unspecified, "unspecified"))
        }
        return s
    }
    
    /// The name of the enum value
    /// See Also: https://developer.apple.com/ios/human-interface-guidelines/visual-design/typography/
    public var name: String {
        let size = UIContentSizeCategory
            .sizes
            .filter({ $0.value == self })
            .first
        
        if let n = size?.name {
            return n
        }
        else {
            return "🤔"
        }
    }
}
