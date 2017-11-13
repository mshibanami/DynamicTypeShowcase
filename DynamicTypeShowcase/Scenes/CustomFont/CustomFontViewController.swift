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

class CustomFontViewController: UIViewController, Versionable {
    var availableOSVersion = OperatingSystemVersion(majorVersion: 11, minorVersion: 0, patchVersion: 0)

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var currentFontButton: UIButton!

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        presentVersionAlertIfNeeded(completion: {
            self.navigationController?.dismiss(animated: true, completion: nil)
        })
    }

    // MARK: IBAction

    @IBAction func touchUpInsideCurrentFontButton(_ sender: UIButton) {
        let vc = FontPickerPopoverViewController.instantiate()
        vc.showPopover(
            sourceView: sender,
            sourceRect: sender.bounds)
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

        let textStyle = UIFontTextStyle.values[indexPath.row]
        let fontName = UIFont.familyNames[5]
        let fontSize: CGFloat = 20.0
        let originalFont = UIFont(name: fontName, size: fontSize)!
        let fontMetrics = UIFontMetrics(forTextStyle: textStyle)
        let maxFontSize: CGFloat? = 30.0
        let scaledFont: UIFont
        if let maxFontSize = maxFontSize {
             scaledFont = fontMetrics.scaledFont(for: originalFont, maximumPointSize: maxFontSize)
        } else {
            scaledFont = fontMetrics.scaledFont(for: originalFont)
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
