//
//  FontPickerPopoverViewController.swift
//  DynamicTypeShowcase
//
//  Created by abc on 2017/11/14.
//  Copyright © 2017 mshibanami. All rights reserved.
//

import UIKit
import KUIPopOver
import Reusable
import RxSwift
import RxCocoa

class FontPickerPopoverViewController: UIViewController, StoryboardBased {
//    @IBOutlet weak var pickerView: UIPickerView!

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var sizeTextField: UITextField!
    @IBOutlet weak var maxSizeTextField: UITextField!
    @IBOutlet weak var styleTextField: UITextField!

    var font = Variable<UIFont?>(nil)
    var maxSize = Variable<Int?>(nil)

    var namePickerView = UIPickerView()
    var stylePickerView = UIPickerView()

    private let availableFontSizes = Array(1...100)

    override func viewDidLoad() {
        super.viewDidLoad()

        var texFields: [UITextField: UIPickerView]
            = [nameTextField: namePickerView,
               styleTextField: stylePickerView]

        for (textField, picker) in texFields {
            picker.dataSource = self
            picker.delegate = self
            textField.inputView = picker
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.preferredContentSize = self.contentSize
    }
}

extension FontPickerPopoverViewController: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case namePickerView:
            return UIFont.familyNames.count
        case stylePickerView:
            return self.availableFontSizes.count
        default:
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case namePickerView:
            return UIFont.familyNames.sorted()[row]
        case stylePickerView:
            UIFont.fontNames(forFamilyName: )
            return String(availableFontSizes[row])
        default:
            return nil
        }
    }
}

extension FontPickerPopoverViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let title = self.pickerView(
            pickerView,
            titleForRow: pickerView.selectedRow(inComponent: 0),
            forComponent: 0)

        switch pickerView {
        case namePickerView:
            nameTextField.text = title
        case stylePickerView:
            styleTextField.text = title
        default:
            break
        }
    }
}

extension FontPickerPopoverViewController: UITextFieldDelegate {
}

extension FontPickerPopoverViewController: KUIPopOverUsable {
    public var contentSize: CGSize {
        return self.view.subviews.first?.bounds.size
            ?? CGSize(width: 0, height: 0)
    }
}
