//
//  FioriBaseTableViewController.swift
//  TravelExpenseApp
//
//  Created by Stadelman, Stan on 2/23/18.
//  Copyright © 2018 Stadelman, Stan. All rights reserved.
//

import SAPFiori
import UIKit

class FioriBaseTableViewController: UITableViewController {
//    var observations: [NSKeyValueObservation] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.cellLayoutMarginsFollowReadableWidth = true

        tableView.register(FUIObjectTableViewCell.self, forCellReuseIdentifier: FUIObjectTableViewCell.reuseIdentifier)
        tableView.register(FUITextFieldFormCell.self, forCellReuseIdentifier: FUITextFieldFormCell.reuseIdentifier)
        tableView.register(FUITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: FUITableViewHeaderFooterView.reuseIdentifier)

        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedSectionHeaderHeight = 44
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
    }
}
