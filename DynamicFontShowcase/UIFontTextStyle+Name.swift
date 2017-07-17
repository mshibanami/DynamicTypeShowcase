//
//  UIFontTextStyle+Name.swift
//  DynamicFontShowcase
//
//  Created by abc on 2017/07/17.
//  Copyright © 2017 mshibanami. All rights reserved.
//

import UIKit

extension UIFontTextStyle {
    
    /// the name of the enum value
    public var name: String {
        // so ugly
        switch self {
        case .title1:
            return "title1"
        case .title2:
            return "title2"
        case .title3:
            return "title3"
        case .headline:
            return "headline"
        case .subheadline:
            return "subheadline"
        case .body:
            return "body"
        case .callout:
            return "callout"
        case .footnote:
            return "footnote"
        case .caption1:
            return "caption1"
        case .caption2:
            return "caption2"
        default:
            return "☠️"
        }
    }
}
