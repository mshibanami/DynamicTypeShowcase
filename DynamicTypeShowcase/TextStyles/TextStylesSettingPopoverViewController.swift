//
//  TextStylesSettingPopoverViewController.swift
//  DynamicTypeShowcase
//
//  Created by abc on 2017/11/03.
//  Copyright © 2017 mshibanami. All rights reserved.
//

import Foundation
import KUIPopOver
import TGPControls

class TextStylesSettingPopoverViewController: UIViewController {
    @IBOutlet weak var useSizeForSceneSwitch: UISwitch!
    @IBOutlet weak var sizeSlider: TGPDiscreteSlider!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension TextStylesSettingPopoverViewController: KUIPopOverUsable {
    var contentSize: CGSize {
        return self.view.subviews.first?.bounds.size
            ?? CGSize(width: 300, height: 100)
    }
}
