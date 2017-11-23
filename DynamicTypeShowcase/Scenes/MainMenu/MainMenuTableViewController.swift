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

    let aboutThisAppCell: UITableViewCell = {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = "Text Styles"
        return cell
    }()

    private typealias Cell = (cell: UITableViewCell, didSelect: () -> Void)

    private lazy var cells: [[Cell]] = [
        [
            Cell(
                cell: {
                    let cell = DynamicTypeableTableViewCell.loadFromNib()
                    cell.textLabel?.text = "Text Styles"
                    return cell}(),
                didSelect: { [weak self] in
                    self?.navigationController?.pushViewController(
                        TextStylesViewController.instantiate(),
                        animated: true)
            }),
            Cell(
                cell: {
                    let cell = DynamicTypeableTableViewCell.loadFromNib()
                    cell.titleLabel?.text = "Images"
                    return cell }(),
                didSelect: { [weak self] in
                    self?.navigationController?.pushViewController(
                        ImageViewController.instantiate(),
                        animated: true)
            }),
            Cell(
                cell: {
                    let cell = DynamicTypeableTableViewCell.loadFromNib()
                    cell.titleLabel?.text = "Custom Font"
                    return cell }(),
                didSelect: { [weak self] in
                    self?.navigationController?.pushViewController(
                        CustomFontViewController.instantiate(),
                        animated: true)
            })
        ],
        [
            Cell(
                cell: {
                    let cell = DynamicTypeableTableViewCell.loadFromNib()
                    cell.titleLabel?.text = "About this App"
                    return cell }(),
                didSelect: { [weak self] in
                    self?.present(
                        SFSafariViewController(url: Const.aboutThisAppURL),
                        animated: true,
                        completion: nil)
            })
        ]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return cells.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cells[indexPath.section][indexPath.row].cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cells[indexPath.section][indexPath.row]
            .didSelect()
    }
}
