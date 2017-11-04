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
            print("csc: \(contentSizeCategory?.name)")
        }
    }

    private let disposeBag = DisposeBag()

    override var traitCollection: UITraitCollection {
        var traits = [super.traitCollection]

        if let contentSizeCategory = self.contentSizeCategory {
            traits.append(
                UITraitCollection(
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
        let size = UIApplication.shared.preferredContentSizeCategory
        let sizeStr = size.name

        title = "Size: "
            + sizeStr
            + (size.isDefault
                ? " (Default)"
                : "")
    }

    @IBAction func touchUpInsideSettingButton(_ sender: UIButton) {
        let vc = UIStoryboard(
            name: String(describing: TextStylesSettingPopoverViewController.self),
            bundle: nil)
            .instantiateInitialViewController()
            as! TextStylesSettingPopoverViewController

        vc.contentSizeCategory.value = self.contentSizeCategory
        vc.contentSizeCategory
            .asObservable()
            .subscribe(onNext: {[weak self] in
                self?.contentSizeCategory = $0
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
        let cell = tableView
            .dequeueReusableCell(withIdentifier: "PreviewCell", for: indexPath) as! TextStylesPreviewCell

        cell.fontTextStyle = UIFontTextStyle.values[indexPath.row]
        cell.sampleText = textField.text ?? ""

        return cell
    }
}

extension TextStylesViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       textField.resignFirstResponder()
       return false
    }
}
