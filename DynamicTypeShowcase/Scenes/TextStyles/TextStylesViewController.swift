//
//  ViewController.swift
//  DynamicTypeShowcase
//
//  Created by abc on 2017/07/17.
//  Copyright © 2017 mshibanami. All rights reserved.
//

import UIKit
import TGPControls
import Reusable
import RxSwift
import RxCocoa

class TextStylesViewController: UIViewController, DynamicTypeAdjustable {

    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet private weak var tableView: UITableView!

    var contentSizeCategory: UIContentSizeCategory? {
        didSet {
            self.updateContentSizeCategory()
            self.tableView.reloadData()
            self.updateTitle()
        }
    }

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(cellType: TextStylesPreviewTableViewCell.self)
        setupTextField()

        updateTitle()
    }

    private func setupTextField() {
        NotificationCenter.default
            .addObserver(
                self,
                selector: #selector(keyboardWillChangeFrame(_:)),
                name: .UIKeyboardWillChangeFrame,
                object: nil)

        NotificationCenter.default
            .addObserver(
                self,
                selector: #selector(contentSizeCategoryDidChange),
                name: .UIContentSizeCategoryDidChange,
                object: nil)

        textField.addTarget(
            self,
            action: #selector(textFieldDidChange(_:)),
            for: .editingChanged)

        view.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(viewDidTap)))
    }

    private func updateTitle() {
        let size = contentSizeCategory
            ?? UIApplication.shared.preferredContentSizeCategory
        let sizeStr = size.name

        title = "Size: "
            + sizeStr
            + (size.isDefault
                ? " (Default)"
                : "")
    }

    /// MARK: IBAction

    @IBAction func touchUpInsideSettingButton(_ sender: UIButton) {
        let vc = SizesSettingPopoverViewController.instantiate()
        vc.adjustableViewController = self
        vc.showPopover(
            sourceView: sender,
            sourceRect: sender.bounds)
    }

    @objc private func contentSizeCategoryDidChange() {
        updateTitle()
        tableView.reloadData()
    }

    // MARK: TextField

    @objc private func keyboardWillChangeFrame(_ notification: Notification) {
        if let endFrame = ((notification as NSNotification)
            .userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?
            .cgRectValue {
            bottomConstraint.constant
                = UIScreen.main.bounds.height - endFrame.origin.y
        }

        view.layoutIfNeeded()
    }

    @objc private func viewDidTap() {
        view.endEditing(true)
    }

    @objc private func textFieldDidChange(_ sender: Any) {
        tableView.reloadData()
    }
}

extension TextStylesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UIFontTextStyle.values.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            for: indexPath,
            cellType: TextStylesPreviewTableViewCell.self)

        cell.fontTextStyle = UIFontTextStyle.values[indexPath.row]
        cell.sampleText = textField.text

        return cell
    }
}

extension TextStylesViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
