//
//  PreviewCell.swift
//  DynamicTypeShowcase
//
//  Created by abc on 2017/07/17.
//  Copyright © 2017 mshibanami. All rights reserved.
//

import UIKit

class TextStylesPreviewCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var summaryLabel: UILabel!
    @IBOutlet private weak var sampleTextLabel: UILabel!

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

    override var traitCollection: UITraitCollection {
        var traits: [UITraitCollection] = [super.traitCollection]

        if let contentSizeCategory = self.contentSizeCategory {
            traits.append(UITraitCollection(
                preferredContentSizeCategory: contentSizeCategory))
        }
        return UITraitCollection(traitsFrom: traits)
    }

    public var sampleText: String = "" {
        didSet {
            updateControls()
        }
    }

    func updateControls() {
        sampleTextLabel.text = sampleText.isEmpty
            ? "\(fontTextStyle?.name ?? " ")"
            : sampleText

        if let style = fontTextStyle {
            let font = UIFont.preferredFont(
                forTextStyle: style,
                compatibleWith: traitCollection)

            titleLabel.text = style.name
            sampleTextLabel.font = font
            summaryLabel.text = "(\(font.fontName) \(font.pointSize)pt)"
        } else {
            titleLabel.text = "🙄"
        }
    }
}
