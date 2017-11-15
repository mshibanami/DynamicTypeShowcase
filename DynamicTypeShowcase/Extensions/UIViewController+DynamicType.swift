//
//  UIViewController+DynamicType.swift
//  DynamicTypeShowcase
//
//  Created by abc on 2017/11/15.
//  Copyright © 2017 mshibanami. All rights reserved.
//

import UIKit

protocol DynamicTypeAdjustable {
    var contentSizeCategory: UIContentSizeCategory? { get }
}

extension DynamicTypeAdjustable where Self: UIViewController {
    /// Update View Controller's content size category with `contentSizeCategory`.
    /// You should call this method MANUALLY😫, generally on `didSet` of `contentSizeCategory`.
    func updateContentSizeCategory() {
        if let vc = self.parent {
            vc.setOverrideTraitCollection(
                UITraitCollection(preferredContentSizeCategory:
                    contentSizeCategory ?? .unspecified),
                forChildViewController: self)
        }
    }
}
