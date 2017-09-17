//
//  MainMenuTableViewController.swift
//  DynamicTypeShowcase
//
//  Created by abc on 2017/09/17.
//  Copyright © 2017 mshibanami. All rights reserved.
//

import UIKit

class MainMenuTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let appName = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String {
            title = appName
        }
    }
}
