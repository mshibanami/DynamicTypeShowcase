//
//  ViewController.swift
//  DynamicTypeShowcase
//
//  Created by abc on 2017/07/17.
//  Copyright © 2017 mshibanami. All rights reserved.
//

import UIKit
import GrowingTextView

class ViewController: UIViewController {
    
    @IBOutlet private weak var textView: GrowingTextView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
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
        
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(tapGestureHandler))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func keyboardWillChangeFrame(_ notification: Notification) {
        let endFrame = ((notification as NSNotification).userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        bottomConstraint.constant = UIScreen.main.bounds.height - endFrame.origin.y
        self.view.layoutIfNeeded()
    }
    
    @objc func tapGestureHandler() {
        view.endEditing(true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fontTextStyles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PreviewCell", for: indexPath) as! PreviewCell
        
        cell.fontTextStyle = fontTextStyles[indexPath.row]
        cell.sampleText = textView.text
        
        return cell
    }
}

extension ViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        tableView.reloadData()
    }
}

extension ViewController: GrowingTextViewDelegate {
    func textViewDidChangeHeight(_ textView: GrowingTextView, height: CGFloat) {
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [.curveLinear], animations: { () -> Void in
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}
