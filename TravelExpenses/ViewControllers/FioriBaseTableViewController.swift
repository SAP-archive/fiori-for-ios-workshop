//
//  FioriBaseTableViewController.swift
//  TravelExpenseApp
//
//  Created by Stadelman, Stan on 2/23/18.
//  Copyright © 2018 SAP SE or an SAP affiliate company. All rights reserved.
//

import SAPFiori
import UIKit

/// Convenience base class for common bootstrapping
class FioriBaseTableViewController: UITableViewController {

    // MARK: View controller hooks

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

        // Hack:  eliminate hairline from bottom of UINavigationBar  https://stackoverflow.com/a/19227158/242447
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refresh), for: .primaryActionTriggered)
    }
    
    @objc func refresh() {
        DataHandler.shared.service.provider.upload(completionHandler: { [weak self] error in
            guard error == nil else {
                DispatchQueue.main.async {
                    self?.refreshControl?.endRefreshing()
                }
                return print("error uploading: \(error.debugDescription)")
            }
            print("Offline Store is uploaded by refresh control")
            DataHandler.shared.service.provider.download(completionHandler: { [weak self] error in
                DispatchQueue.main.async {
                    self?.refreshControl?.endRefreshing()
                    guard error == nil else {
                        return print("error downloading: \(error.debugDescription)")
                    }
                    self?.tableView.reloadData()
                }
                print("Offline Store is downloaded by refresh control")
            })
        })
    }
}
