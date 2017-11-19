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

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var sizeTextField: UITextField!
    @IBOutlet weak var maxSizeTextField: UITextField!
    @IBOutlet weak var styleTextField: UITextField!

    var font = Variable<UIFont!>(nil)
    var maxSize = Variable<CGFloat?>(nil)

    var namePickerView = UIPickerView()
    var stylePickerView = UIPickerView()

    private let availableFontSizes = Array(1...100)

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func setup() {
        self.sizeTextField.text = "\(font.value.pointSize)"
        if let maxSize = maxSize.value {
            self.maxSizeTextField.text = "\(maxSize)"
        } else {
            self.maxSizeTextField.text = ""
        }

        let texFields: [UITextField: UIPickerView]
            = [self.nameTextField: self.namePickerView,
               self.styleTextField: self.stylePickerView]

        for (textField, picker) in texFields {
            picker.dataSource = self
            picker.delegate = self
            textField.inputView = picker
        }

        let name = font.value.familyName
        let nameIdx = UIFont.familyNames.sorted()
            .index(of: name)!
        self.namePickerView.selectRow(
            nameIdx, inComponent: 0, animated: false)

        let fontNames = UIFont.fontNames(forFamilyName: name)
        let styleIdx = fontNames.index(of: font.value.fontName)!

        self.stylePickerView
            .selectRow(styleIdx, inComponent: 0, animated: false)

        self.pickerView(
            namePickerView, didSelectRow: nameIdx, inComponent: 0)
        self.pickerView(
            stylePickerView, didSelectRow: styleIdx, inComponent: 0)

        Observable.combineLatest(
            nameTextField.rx.text.asObservable(),
            sizeTextField.rx.text.asObservable(),
            maxSizeTextField.rx.text.asObservable(),
            styleTextField.rx.text.asObservable()) { (_, _, _, _) -> Void in
                return
            }
            .subscribe(onNext: {[weak self] in
                self?.updateFont()
            })
            .disposed(by: self.disposeBag)
    }

    func updateFont() {
        let name = (self.styleTextField.text?.isEmpty ?? true)
            ? self.nameTextField.text!
            : self.styleTextField.text!
        let size = CGFloat(
            (self.sizeTextField.text! as NSString)
                .floatValue)

        self.font.value = UIFont(name: name, size: size)
        if let maxSizeText = self.maxSizeTextField.text,
            !maxSizeText.isEmpty {
            self.maxSize.value = CGFloat(
                (maxSizeText as NSString).floatValue)
        } else {
            self.maxSize.value = nil
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
            return UIFont
                .fontNames(forFamilyName: nameTextField.text ?? "")
                .count
        default:
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case namePickerView:
            return UIFont.familyNames.sorted()[row]
        case stylePickerView:
            let fontNames = UIFont.fontNames(forFamilyName: nameTextField.text ?? "")
            return fontNames[row]
        default:
            return nil
        }
    }
}

extension FontPickerPopoverViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let title = self.pickerView(
            pickerView,
            titleForRow: row,
            forComponent: 0)

        switch pickerView {
        case namePickerView:
            nameTextField.text = title
            styleTextField.text = UIFont.fontNames(forFamilyName: nameTextField.text ?? "").first
        case stylePickerView:
            styleTextField.text = title
        default:
            break
        }
        self.updateFont()
    }
}

extension FontPickerPopoverViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.updateFont()
        return true
    }
}

extension FontPickerPopoverViewController: KUIPopOverUsable {
    public var contentSize: CGSize {
        return self.view.subviews.first?.bounds.size
            ?? CGSize(width: 0, height: 0)
    }
}
