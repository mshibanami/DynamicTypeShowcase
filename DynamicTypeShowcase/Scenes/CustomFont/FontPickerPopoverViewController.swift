//
//  FontPickerPopoverViewController.swift
//  DynamicTypeShowcase
//
//  Created by abc on 2017/11/14.
//  Copyright © 2017 mshibanami. All rights reserved.
//

import UIKit
import Reusable
import KUIPopOver

class FontPickerPopoverViewController: UIViewController, StoryboardBased {
    @IBOutlet weak var pickerView: UIPickerView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension FontPickerPopoverViewController: UIPickerViewDataSource {
    enum TableSection: Int {
        case name
        case pointSize
        case maxSize

        var values: [TableSection] {
            return [TableSection.name,
                    TableSection.pointSize,
                    TableSection.maxSize]
        }
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch TableSection(rawValue: component)! {
        case .name:
            return "name"
        case .pointSize:
            return "pointSize"
        case .maxSize:
            return "maxSize"
        }

    }
}

extension FontPickerPopoverViewController: UIPickerViewDelegate {
}
