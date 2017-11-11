//
//  ImageTableViewCell.swift
//  DynamicTypeShowcase
//
//  Created by abc on 2017/11/09.
//  Copyright © 2017 mshibanami. All rights reserved.
//

import UIKit
import Reusable

class ImageTableViewCell: UITableViewCell, Reusable {

    @IBOutlet weak var scalableImageView: UIImageView!
    @IBOutlet weak var originalSizeLabel: UILabel!
    @IBOutlet weak var currentSizeLabel: UILabel!

    override func layoutSubviews() {
        super.layoutSubviews()

        let imageViewSize = self.scalableImageView.frame.size
        self.currentSizeLabel.text = "current size: \(imageViewSize.width)x\(imageViewSize.height)"
    }
}
