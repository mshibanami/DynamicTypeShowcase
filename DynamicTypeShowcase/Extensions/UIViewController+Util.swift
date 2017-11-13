//
//  UIViewController.swift
//  DynamicTypeShowcase
//
//  Created by abc on 2017/11/13.
//  Copyright © 2017 mshibanami. All rights reserved.
//

import UIKit

protocol Versionable {
    var availableOSVersion: OperatingSystemVersion { get }

    func presentVersionAlertIfNeeded(completion:(() -> Void)?)
}

extension Versionable where Self: UIViewController {

    func presentVersionAlertIfNeeded(completion:(() -> Void)?) {
        let osVersion = ProcessInfo.processInfo.operatingSystemVersion

        if osVersion < self.availableOSVersion {
            let alert = UIAlertController(
                title: "Not Available",
                message: "This feature of Dynamic Type is only available on iOS \(osVersion.string) or later.",
                preferredStyle: .alert)

            let cancelAction = UIAlertAction(
                title: "OK",
                style: .cancel,
                handler: { [weak self] _ in
                    completion?()
                    self?.navigationController?
                        .popViewController(animated: true)
            })
            alert.addAction(cancelAction)

            present(alert, animated: true)
            return
        }
    }
}
