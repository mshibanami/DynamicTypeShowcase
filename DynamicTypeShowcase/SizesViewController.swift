//
//  ViewController.swift
//  DynamicTypeShowcase
//
//  Created by abc on 2017/07/17.
//  Copyright © 2017 mshibanami. All rights reserved.
//

import UIKit

class SizesViewController: UIViewController {
    
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        updateTitle()
        
        NotificationCenter
            .default
            .addObserver(
                self,
                selector: #selector(keyboardWillChangeFrame(_:)),
                name: .UIKeyboardWillChangeFrame,
                object: nil)
        
        NotificationCenter
            .default
            .addObserver(
                self,
                selector: #selector(contentSizeCategoryDidChange),
                name: .UIContentSizeCategoryDidChange,
                object: nil)
        
        textField.addTarget(
            self,
            action: #selector(textFieldDidChange(_:)),
            for: .editingChanged)
        
        let gesture = UITapGestureRecognizer(
            target: self,
            action: #selector(viewDidTap))
        view.addGestureRecognizer(gesture)
    }
    private func updateTitle() {
        let size = UIApplication.shared.preferredContentSizeCategory
        let sizeStr = size.name
        
        title = "Size: "
            + sizeStr
            + (size == .large
                ? " (Default)"
                : "")
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

extension SizesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UIFontTextStyle.values.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView
            .dequeueReusableCell(withIdentifier: "PreviewCell", for: indexPath) as! PreviewCell
        
        cell.fontTextStyle = UIFontTextStyle.values[indexPath.row]
        cell.sampleText = textField.text ?? ""
        
        return cell
    }
}

extension SizesViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        viewDidTap()
    }
}

extension SizesViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       textField.resignFirstResponder()
       return false
    }
}
