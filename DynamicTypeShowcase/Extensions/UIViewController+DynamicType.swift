//
//  UIViewController+DynamicType.swift
//  DynamicTypeShowcase
//
//  Created by abc on 2017/11/15.
//  Copyright © 2017 mshibanami. All rights reserved.
//

import UIKit

/// This protocol is only for UIViewController and its subclasses.
protocol DynamicTypeAdjustable: class {
    var contentSizeCategory: UIContentSizeCategory? { get set }
}

extension DynamicTypeAdjustable where Self: UIViewController {
    /// Update the view controller's content size category with `contentSizeCategory`.
    /// You should call this method MANUALLY😫, generally on `didSet` of `contentSizeCategory`.
    func updateContentSizeCategory() {
        if let vc = self.parent {
            vc.setOverrideTraitCollection(
                UITraitCollection(preferredContentSizeCategory:
                    contentSizeCategory ?? .unspecified),
                forChildViewController: self)
        }
    }

    func updateTitle() {
        let size = self.traitCollection.preferredContentSizeCategory
        let sizeStr = size.name

        title = "Size: "
            + sizeStr
            + (size.isDefault
                ? " (Default)"
                : "")
    }
}
