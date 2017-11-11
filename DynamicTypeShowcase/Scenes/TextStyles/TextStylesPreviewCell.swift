//
//  PreviewCell.swift
//  DynamicTypeShowcase
//
//  Created by abc on 2017/07/17.
//  Copyright © 2017 mshibanami. All rights reserved.
//

import UIKit

class TextStylesPreviewCell: UITableViewCell {
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

    // HACK: Generally traitConllection should NOT be overriden.
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

            textStyleLabel.text = style.name
            sampleTextLabel.font = font
            fontLabel.text = "(\(font.fontName) \(font.pointSize)pt)"
        } else {
            textStyleLabel.text = "🙄"
        }
    }
}
