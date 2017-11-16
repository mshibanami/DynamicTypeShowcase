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
//    @IBOutlet weak var pickerView: UIPickerView!

    private let availableFontSizes = Array(1...100)

    override func viewDidLoad() {
        super.viewDidLoad()
//        pickerView.selectRow(
//            5,
//            inComponent: Section.name.rawValue,
//            animated: false)
//
//        pickerView.selectRow(
//            5,
//            inComponent: Section.pointSize.rawValue,
//            animated: false)
//
//        pickerView.selectRow(
//            5,
//            inComponent: Section.maxSize.rawValue,
//            animated: false)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.preferredContentSize = self.contentSize
    }
}

//extension FontPickerPopoverViewController: UIPickerViewDataSource {
//    enum Section: Int {
//        case name
//        case pointSize
//        case maxSize
//
//        static var values: [Section] {
//            return [Section.name,
//                    Section.pointSize,
//                    Section.maxSize]
//        }
//    }
//
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return Section.values.count
//    }
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        switch Section(rawValue: component)! {
//        case .name:
//            return UIFont.familyNames.count
//        case .pointSize, .maxSize:
//            return self.availableFontSizes.count
//        }
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        switch Section(rawValue: component)! {
//        case .name:
//            return UIFont.familyNames.sorted()[row]
//        case .pointSize, .maxSize:
//            return String(availableFontSizes[row])
//        }
//    }
//
//    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
//        switch Section(rawValue: component)! {
//        case .name:
//            return self.pickerView.bounds.width - (50 * 2) - 60
//        case .pointSize, .maxSize:
//            return 50.0
//        }
//    }
//}

extension FontPickerPopoverViewController: UIPickerViewDelegate {
}

extension FontPickerPopoverViewController: KUIPopOverUsable {
    public var contentSize: CGSize {
        return self.view.subviews.first?.bounds.size
            ?? CGSize(width: 0, height: 0)
    }
}
