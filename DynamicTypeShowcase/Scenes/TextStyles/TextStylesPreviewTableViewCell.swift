//
//  TextStylesPreviewTableViewCell.swift
//  DynamicTypeShowcase
//
//  Created by abc on 2017/07/17.
//  Copyright © 2017 mshibanami. All rights reserved.
//

import UIKit
import Reusable

class TextStylesPreviewTableViewCell: UITableViewCell, NibReusable {
    @IBOutlet private weak var sampleTextLabel: UILabel!
    @IBOutlet private weak var textStyleLabel: UILabel!
    @IBOutlet private weak var fontLabel: UILabel!

    /// Style for sample text
    public var fontTextStyle: UIFontTextStyle? {
        didSet {
            updateControls()
        }
    }

    public var sampleText: String? {
        didSet {
            updateControls()
        }
    }

    func updateControls() {
        if let sampleText = self.sampleText,
            !sampleText.isEmpty {
            sampleTextLabel.text = sampleText
        } else {
            sampleTextLabel.text = "\(fontTextStyle?.name ?? " ")"
        }

        if let style = fontTextStyle {
            let font = UIFont.preferredFont(
                forTextStyle: style,
                compatibleWith: traitCollection)

            textStyleLabel.text = style.name
            sampleTextLabel.font = font
            fontLabel.text = "(\(font.fontName) \(font.pointSize)pt)"
        } else {
            textStyleLabel.text = "🙄"
        }
    }
}
