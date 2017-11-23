//
//  DynamicTypeableTableViewCell.swift
//  DynamicTypeShowcase
//
//  Created by abc on 2017/11/23.
//  Copyright © 2017 mshibanami. All rights reserved.
//

import UIKit
import Reusable

/// TableViewCell that works properly even on change DynamicType's content size category on runtime.
/// Normal UITableViewCell has a bug. It doesn't work properly on Dynamic Type.
/// At least the bug still continuing on iOS11
/// This is the solution for it.
class DynamicTypeableTableViewCell: UITableViewCell, NibReusable {
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet private weak var stackView: UIStackView!

    override func prepareForReuse() {
        super.prepareForReuse()
        self.updateControls()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.updateControls()
    }

    private func updateControls() { // swiftlint:disable:this function_body_length cyclomatic_complexity
        // WTF
        switch traitCollection.preferredContentSizeCategory {
        case .extraSmall:
            stackView.layoutMargins = UIEdgeInsets(
                top: 13.3,
                left: 16,
                bottom: 13.3,
                right: 0)
        case .small:
            stackView.layoutMargins = UIEdgeInsets(
                top: 12.75,
                left: 16,
                bottom: 12.75,
                right: 0)
        case .medium:
            stackView.layoutMargins = UIEdgeInsets(
                top: 12,
                left: 16,
                bottom: 12,
                right: 0)
        case .large:
            stackView.layoutMargins = UIEdgeInsets(
                top: 13,
                left: 16,
                bottom: 13,
                right: 0)
        case .extraLarge:
            stackView.layoutMargins = UIEdgeInsets(
                top: 13.25,
                left: 16,
                bottom: 13.25,
                right: 0)
        case .extraExtraLarge:
            stackView.layoutMargins = UIEdgeInsets(
                top: 13.5,
                left: 16,
                bottom: 13.5,
                right: 0)
        case .extraExtraExtraLarge:
            stackView.layoutMargins = UIEdgeInsets(
                top: 14.5,
                left: 16,
                bottom: 14.5,
                right: 0)
        case .accessibilityMedium:
            stackView.layoutMargins = UIEdgeInsets(
                top: 17.5,
                left: 16,
                bottom: 17.5,
                right: 0)
        case .accessibilityLarge:
            stackView.layoutMargins = UIEdgeInsets(
                top: 20.5,
                left: 16,
                bottom: 20.5,
                right: 0)
        case .accessibilityExtraLarge:
            stackView.layoutMargins = UIEdgeInsets(
                top: 24.5,
                left: 16,
                bottom: 24.5,
                right: 0)
        case .accessibilityExtraExtraLarge:
            stackView.layoutMargins = UIEdgeInsets(
                top: 28,
                left: 16,
                bottom: 28,
                right: 0)
        case .accessibilityExtraExtraExtraLarge:
            stackView.layoutMargins = UIEdgeInsets(
                top: 33,
                left: 16,
                bottom: 33,
                right: 0)
        default:
            stackView.layoutMargins = UIEdgeInsets(
                top: 13,
                left: 16,
                bottom: 13,
                right: 0)
        }
    }
}
