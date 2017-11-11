//
//  MainMenuTableViewController.swift
//  DynamicTypeShowcase
//
//  Created by abc on 2017/09/17.
//  Copyright © 2017 mshibanami. All rights reserved.
//

import UIKit
import SafariServices

class MainMenuTableViewController: UITableViewController {

    @IBOutlet weak var aboutThisAppCell: UITableViewCell!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else {
            return
        }

        switch cell {
        case aboutThisAppCell:
            jumpToAboutThisApp()
        default:
            break
        }
    }

    private func jumpToAboutThisApp() {
        present(
            SFSafariViewController(url: Const.aboutThisAppURL),
            animated: true)

    }
}
