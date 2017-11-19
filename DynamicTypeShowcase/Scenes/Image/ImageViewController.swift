//
//  ImageViewController.swift
//  DynamicTypeShowcase
//
//  Created by abc on 2017/11/08.
//  Copyright © 2017 mshibanami. All rights reserved.
//

import UIKit
import Reusable
import KUIPopOver

class ImageViewController: UIViewController, DynamicTypeAdjustable {
    var contentSizeCategory: UIContentSizeCategory? {
        didSet {
            updateContentSizeCategory()
            updateTitle()
            self.tableView.reloadData()
        }
    }

    @IBOutlet weak var tableView: UITableView!

    private let imageNames: [String] = [
        "SampleImage1_40x40",
        "SampleImage2_40x40",
        "SampleImage3_40x40" ]

    override func viewDidLoad() {
        super.viewDidLoad()
        updateTitle()
        self.tableView.register(cellType: ImageTableViewCell.self)
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateTitle()
    }

    // MARK: IBAction

    @IBAction func onTapSizeSettingButton(_ sender: UIBarButtonItem) {
        let vc = SizesSettingPopoverViewController.instantiate()
        vc.adjustableViewController = self
        vc.showPopover(barButtonItem: sender)
    }
}

extension ImageViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageNames.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            for: indexPath,
            cellType: ImageTableViewCell.self)

        let imgName = imageNames[indexPath.row]
        let img = UIImage(named: imgName,
                          in: nil,
                          compatibleWith: traitCollection)!
        cell.scalableImageView.image = img
        cell.originalSizeLabel.text
            = "original size: \(img.size.width)x\(img.size.height)"
        return cell
    }
}

extension ImageViewController: UITableViewDelegate {

}
