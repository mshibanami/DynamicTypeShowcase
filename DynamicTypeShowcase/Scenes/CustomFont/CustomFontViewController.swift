//
//  CustomFontViewController.swift
//  DynamicTypeShowcase
//
//  Created by abc on 2017/11/09.
//  Copyright © 2017 mshibanami. All rights reserved.
//

import UIKit
import Reusable
import RxSwift
import RxCocoa
import KUIPopOver

class CustomFontViewController: UIViewController, Versionable, DynamicTypeAdjustable {

    var availableOSVersion = OperatingSystemVersion(majorVersion: 11, minorVersion: 0, patchVersion: 0)

    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var currentFontButton: UIButton!
    @IBOutlet weak var textField: UITextField!

    var contentSizeCategory: UIContentSizeCategory? {
        didSet {
            updateContentSizeCategory()
        }
    }

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        presentVersionAlertIfNeeded(completion: {
            self.navigationController?.dismiss(animated: true, completion: nil)
        })
        setupTextField()
    }

    // MARK: IBAction

    @IBAction func onTapCurrentFontButton(_ sender: UIButton) {
        let vc = FontPickerPopoverViewController.instantiate()
        vc.showPopover(
            sourceView: sender,
            sourceRect: sender.bounds)
    }

    @IBAction func onTapSizeSettingButton(_ sender: UIButton) {
        let vc = SizesSettingPopoverViewController.instantiate()
        vc.adjustableViewController = self
        vc.showPopover(
            sourceView: sender,
            sourceRect: sender.bounds)
    }

    // MARK: TextField

    private func setupTextField() {
        NotificationCenter.default
            .addObserver(
                self,
                selector: #selector(keyboardWillChangeFrame(_:)),
                name: .UIKeyboardWillChangeFrame,
                object: nil)

        self.textField.addTarget(
            self,
            action: #selector(textFieldDidChange(_:)),
            for: .editingChanged)

        view.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(viewDidTap)))
    }

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

extension CustomFontViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UIFontTextStyle.values.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard #available(iOS 11, *) else {
            return UITableViewCell()
        }

        let cell = tableView.dequeueReusableCell(
            for: indexPath,
            cellType: CustomFontTableViewCell.self)

        let fontName = UIFont.familyNames[5] // TODO
        let fontSize: CGFloat = 20.0 // TODO
        let maxFontSize: CGFloat? = 30.0 // TODO

        let textStyle = UIFontTextStyle.values[indexPath.row]
        let originalFont = UIFont(name: fontName, size: fontSize)!
        let fontMetrics = UIFontMetrics(forTextStyle: textStyle)
        let scaledFont: UIFont
        if let maxFontSize = maxFontSize {
             scaledFont = fontMetrics.scaledFont(
                for: originalFont,
                maximumPointSize: maxFontSize,
                compatibleWith: traitCollection)
        } else {
            scaledFont = fontMetrics.scaledFont(
                for: originalFont,
                compatibleWith: traitCollection)
        }

        if let t =  self.textField.text,
            !t.isEmpty {
            cell.sampleTextLabel.text = t
        } else {
            cell.sampleTextLabel.text = textStyle.name
        }

        cell.sampleTextLabel.font = scaledFont
        cell.textStyleLabel.text = "\(textStyle.name)"

        var fontLabelText = "(\(scaledFont.fontName) " + "\(scaledFont.pointSize)pt) "
        if let maxFontSize = maxFontSize {
            fontLabelText += "- max:\(maxFontSize) pt"
        }
        cell.fontLabel.text = fontLabelText

        return cell
    }
}

extension CustomFontViewController: UITableViewDelegate {

}
