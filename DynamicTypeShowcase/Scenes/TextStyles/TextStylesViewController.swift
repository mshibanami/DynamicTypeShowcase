//
//  ViewController.swift
//  DynamicTypeShowcase
//
//  Created by abc on 2017/07/17.
//  Copyright © 2017 mshibanami. All rights reserved.
//

import UIKit
import TGPControls
import RxSwift
import RxCocoa

class TextStylesViewController: UIViewController {

    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet private weak var tableView: UITableView!

    private var contentSizeCategory: UIContentSizeCategory? {
        didSet {
            self.tableView.reloadData()
            self.updateTitle()
        }
    }

    private let disposeBag = DisposeBag()

    // HACK: Generally traitConllection should NOT be overriden.
    override var traitCollection: UITraitCollection {
        var traits: [UITraitCollection] = [super.traitCollection]

        if let contentSizeCategory = self.contentSizeCategory {
            traits.append(UITraitCollection(
                preferredContentSizeCategory: contentSizeCategory))
        }
        return UITraitCollection(traitsFrom: traits)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        updateTitle()
        setupTextField()
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

    @IBAction func touchUpInsideSettingButton(_ sender: UIButton) {
        let vc = UIStoryboard(
            name: String(describing: SizesSettingPopoverViewController.self),
            bundle: nil)
            .instantiateInitialViewController()
            as! SizesSettingPopoverViewController

        if let category = self.contentSizeCategory {
            vc.contentSizeCategory.value = category
        }
        vc.usesSizeForScene.value = (self.contentSizeCategory != nil)

        Observable.combineLatest(
            vc.contentSizeCategory.asObservable(),
            vc.usesSizeForScene.asObservable()) { category, _ in
                return category
            }
            .subscribe(onNext: {[weak self, weak vc] in
                self?.contentSizeCategory = (vc?.usesSizeForScene.value ?? false)
                    ? $0
                    : nil
            })
            .disposed(by: self.disposeBag)

        vc.showPopover(
            sourceView: sender,
            sourceRect: sender.bounds)
    }

    @objc private func contentSizeCategoryDidChange() {
        updateTitle()
        tableView.reloadData()
    }

    @objc private func keyboardWillChangeFrame(_ notification: Notification) {
        let endFrame = ((notification as NSNotification)
            .userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue)
            .cgRectValue

        bottomConstraint.constant = UIScreen.main.bounds.height - endFrame.origin.y

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
            withIdentifier: "TextStylesPreviewCell",
            for: indexPath) as! TextStylesPreviewCell

        cell.fontTextStyle = UIFontTextStyle.values[indexPath.row]
        cell.sampleText = textField.text ?? ""
        cell.contentSizeCategory = self.contentSizeCategory

        return cell
    }
}

extension TextStylesViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
