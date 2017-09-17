//
//  UIFontTextStyle+Name.swift
//  DynamicTypeShowcase
//
//  Created by abc on 2017/07/17.
//  Copyright © 2017 mshibanami. All rights reserved.
//

import UIKit

extension UIFontTextStyle {
    
    /// The name of the enum value
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
            break
        }
        
        if #available(iOS 11.0, *) {
            switch self {
            case .largeTitle:
                return "largeTitle"
            default:
                break
            }
        }
        
        return "☠"
    }
    
    /// All enum values
    public static var values: [UIFontTextStyle] {
        var v: [UIFontTextStyle] = []
        
        if #available(iOS 11.0, *) {
            v.append(largeTitle)
        }
        
        v.append(contentsOf: [
            .title1,
            .title2,
            .title3,
            .headline,
            .subheadline,
            .body,
            .callout,
            .footnote,
            .caption1,
            .caption2,
        ])
        
        return v
    }
}
