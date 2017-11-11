//
//  TextStylesPreviewTableViewCell.swift
//  DynamicTypeShowcase
//
//  Created by abc on 2017/07/17.
//  Copyright © 2017 mshibanami. All rights reserved.
//

import UIKit
import Reusable

class TextStylesPreviewTableViewCell: UITableViewCell, Reusable {
    @IBOutlet private weak var sampleTextLabel: UILabel!
    @IBOutlet private weak var textStyleLabel: UILabel!
    @IBOutlet private weak var fontLabel: UILabel!

    /// Style for sample text
    public var fontTextStyle: UIFontTextStyle? {
        didSet {
            updateControls()
        }
    }

    var contentSizeCategory: UIContentSizeCategory? {
        didSet {
            updateControls()
        }
    }

    public var sampleText: String? {
        didSet {
            updateControls()
        }
    }

    // HACK: Generally traitConllection should NOT be overriden.
    override var traitCollection: UITraitCollection {
        var traits: [UITraitCollection] = [super.traitCollection]

        if let contentSizeCategory = self.contentSizeCategory {
            traits.append(UITraitCollection(
                preferredContentSizeCategory: contentSizeCategory))
        }
        return UITraitCollection(traitsFrom: traits)
    }

    func updateControls() {
        if let sampleText = self.sampleText,
            !sampleText.isEmpty {
            sampleTextLabel.text = "\(fontTextStyle?.name ?? " ")"
        } else {
            sampleTextLabel.text = sampleText
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
