//
//  ImageViewController.swift
//  DynamicTypeShowcase
//
//  Created by abc on 2017/11/08.
//  Copyright © 2017 mshibanami. All rights reserved.
//

import UIKit
import Reusable

class ImageViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    let images = [#imageLiteral(resourceName: "SampleImage1_40x40"), #imageLiteral(resourceName: "SampleImage2_40x40"), #imageLiteral(resourceName: "SampleImage3_40x40")]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ImageViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            for: indexPath,
            cellType: ImageTableViewCell.self)

        let img = images[indexPath.row]
        cell.scalableImageView.image = img
        cell.originalSizeLabel.text = "original size: \(img.size.width)x\(img.size.height)"

        return cell
    }
}

extension ImageViewController: UITableViewDelegate {

}
