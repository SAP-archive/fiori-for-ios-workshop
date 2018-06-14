//
//  ReservationsTableViewController.swift
//  TravelExpenseApp
//
//  Created by Stadelman, Stan on 2/23/18.
//  Copyright © 2018 SAP SE or an SAP affiliate company. All rights reserved.
//

import SAPFiori
import SAPOData
import UIKit

class TripsTableViewController: FioriBaseTableViewController {
    
    // MARK: - Model
    
    var entities: [TripItemType] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }

    // MARK: View controller hooks
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Reservations"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let query = DataQuery().expand(TripItemType.reservations)
        DataHandler.shared.service.fetchTripItem(matching: query) { (items, error) in
            guard let entities = items else {
                return print(String(describing: error.debugDescription))
            }
            self.entities = entities
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in _: UITableView) -> Int {
        return self.entities.count + 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section < tableView.numberOfSections - 1 else {
            return 1
        }
        return self.entities[section].reservations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.section < tableView.numberOfSections - 1 else {
            let cell = tableView.dequeueReusableCell(withIdentifier: FUITextFieldFormCell.reuseIdentifier, for: indexPath) as! FUITextFieldFormCell
            cell.keyLabel.text = "History Reservations"
            cell.value = "\(entities.count)"
            cell.isEditable = false
            cell.accessoryType = .disclosureIndicator
            return cell
        }

        let trip = entities[indexPath.section]
        let item = trip.reservations[indexPath.row]

        let dateFormatter: DateFormatter = {
            let df = DateFormatter()
            df.dateStyle = .full
            return df
        }()

        let cell = tableView.dequeueReusableCell(withIdentifier: FUIObjectTableViewCell.reuseIdentifier, for: indexPath) as! FUIObjectTableViewCell
        cell.detailImageView.image = #imageLiteral(resourceName: "skyline6 copy")
        cell.headlineText = item.reservationtitle
        cell.headlineLabel.numberOfLines = 2
        cell.subheadlineText = "Confirmation: \(item.confirmation!)"
        cell.footnoteText = "\(dateFormatter.string(from: item.reservationdate!.utc()))"
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section < tableView.numberOfSections - 1 else {
            return nil
        }
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: FUITableViewHeaderFooterView.reuseIdentifier) as! FUITableViewHeaderFooterView
        view.titleLabel.text = entities[section].description
        return view
    }
}
