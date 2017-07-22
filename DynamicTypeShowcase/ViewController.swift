//
//  ViewController.swift
//  DynamicTypeShowcase
//
//  Created by abc on 2017/07/17.
//  Copyright © 2017 mshibanami. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet private weak var tableView: UITableView!
    
    private var fontTextStyles: [UIFontTextStyle] {
        return [
            .title1,
            .title2,
            .title3,
            .headline,
            .subheadline,
            .body,
            .callout,
            .footnote,
            .caption1,
            .caption2,
        ]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter
            .default
            .addObserver(
                self,
                selector: #selector(keyboardWillChangeFrame(_:)),
                name: .UIKeyboardWillChangeFrame,
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
    
    @objc private func keyboardWillChangeFrame(_ notification: Notification) {
        let endFrame = ((notification as NSNotification)
            .userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue)
            .cgRectValue
        
        bottomConstraint.constant = UIScreen.main.bounds.height - endFrame.origin.y
        
        self.view.layoutIfNeeded()
    }
    
    @objc private func viewDidTap() {
        view.endEditing(true)
    }
    
    @objc private func textFieldDidChange(_ sender: Any) {
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fontTextStyles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView
            .dequeueReusableCell(withIdentifier: "PreviewCell", for: indexPath) as! PreviewCell
        
        cell.fontTextStyle = fontTextStyles[indexPath.row]
        cell.sampleText = textField.text ?? ""
        
        return cell
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        viewDidTap()
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       textField.resignFirstResponder()
       return false
    }
}
