//
//  ImageTableViewCell.swift
//  DynamicTypeShowcase
//
//  Created by abc on 2017/11/09.
//  Copyright © 2017 mshibanami. All rights reserved.
//

import UIKit
import Reusable

class ImageTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var scalableImageView: UIImageView!
    @IBOutlet weak var originalSizeLabel: UILabel!
    @IBOutlet private weak var currentSizeLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        updateControls()
    }

    func updateControls() {
        // HACK: This is a workaround to apply the overrided traitCollection to the imageView.
        // iOS11 or later supports scaled image with Size Category.
        // But currently, it looks work fine only for global size category (`UIApplication.preferredContentSizeCategory`)
        // Not for overrided traitCollection with `UIViewController.setOverrideTraitCollection(_:forChildViewController:)`
        // I suspect this is a iOS11's bug...
        // So I wrote this code to avoid it.
        // We, 3rd party developers, should not call traitCollectionDidChange() manually.
        // But I do anyway because it works fine for some reasons.
        self.scalableImageView.traitCollectionDidChange(nil)
        self.scalableImageView.sizeToFit()

        let imageViewSize = self.scalableImageView.frame.size
        self.currentSizeLabel.text = "current size: \(imageViewSize.width)x\(imageViewSize.height)"
    }
}
