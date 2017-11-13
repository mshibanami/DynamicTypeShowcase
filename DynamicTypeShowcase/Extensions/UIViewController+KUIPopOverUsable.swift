//
//  UIViewController+KUIPopOverUsable.swift
//  DynamicTypeShowcase
//
//  Created by abc on 2017/11/14.
//  Copyright © 2017 mshibanami. All rights reserved.
//

import UIKit
import KUIPopOver

extension UIViewController: KUIPopOverUsable {
    public var contentSize: CGSize {
        return self.view.subviews.first?.bounds.size
            ?? CGSize(width: 300, height: 100)
    }
}
