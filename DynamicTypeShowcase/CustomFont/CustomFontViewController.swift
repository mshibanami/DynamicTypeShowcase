//
//  CustomFontViewController.swift
//  DynamicTypeShowcase
//
//  Created by abc on 2017/11/09.
//  Copyright © 2017 mshibanami. All rights reserved.
//

import UIKit

class CustomFontViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
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
            withIdentifier: "CustomFontTableViewCell",
            for: indexPath)
            as! CustomFontTableViewCell

        let textStyle = UIFontTextStyle.values[indexPath.row]
        let fontName = UIFont.familyNames[5]
        let fontSize: CGFloat = 20.0
        let font = UIFont(name: fontName, size: fontSize)!
        let fontMetrics = UIFontMetrics(forTextStyle: textStyle)

        cell.sampleTextLabel.font = fontMetrics.scaledFont(for: font)
        cell.textStyleNameLabel.text = "TextStyle: \(textStyle.name)"
        cell.fontNameLabel.text = fontName
        cell.fontSizeLabel.text = "\(fontSize)pt"

        return cell
    }
}

extension CustomFontViewController: UITableViewDelegate {

}
