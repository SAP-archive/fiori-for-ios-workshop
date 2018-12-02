//
//  ReportsTableViewController.swift
//  TravelExpenseApp
//
//  Created by Stadelman, Stan on 2/23/18.
//  Copyright © 2018 SAP SE or an SAP affiliate company. All rights reserved.
//

import SAPFiori
import SAPOData
import UIKit



class ReportsTableViewController: FioriBaseTableViewController {

    // MARK: - Model

    var expenseReports: [ExpenseReportItem] = [] {
        didSet {
            
            activeExpenseReports = expenseReports.filter({ $0.reportstatusid == "ACT" }).sorted(by: { lhs, rhs in
                guard let lStart = lhs.reportstart, let rStart = rhs.reportstart else { return false }
                return lStart < rStart
            })
            
            submittedExpenseReports = expenseReports.filter({ $0.reportstatusid != "ACT" }).sorted(by: { lhs, rhs in
                guard let lStart = lhs.reportstart, let rStart = rhs.reportstart else { return false }
                return lStart < rStart
            })
            
            self.tableView.reloadData()
        }
    }

    private var activeExpenseReports: [ExpenseReportItem] = []
    private var submittedExpenseReports: [ExpenseReportItem] = []

    // MARK: View controller hooks

    private var downloadCompleteObserver: Any?

    deinit {
        if let downloadCompleteObserver = downloadCompleteObserver {
            NotificationCenter.default.removeObserver(downloadCompleteObserver)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let addButton = UIBarButtonItem(image: FUIIconLibrary.system.create.withRenderingMode(.alwaysTemplate), landscapeImagePhone: nil, style: .plain, target: self, action: #selector(self.addReport))
        self.navigationItem.rightBarButtonItems = [addButton]
        self.navigationItem.title = "Expense Reports"

        downloadCompleteObserver = NotificationCenter.default.addObserver(forName: DataHandler.downloadCompleteNotification, object: nil, queue: .main) { [unowned self] _ in
            self.reloadReports()
        }
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        reloadReports()
    }

    // MARK: - Table view data source

    override func numberOfSections(in _: UITableView) -> Int {
        return 2
    }

    override func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.activeExpenseReports.count
        case 1:
            return self.submittedExpenseReports.count
        default:
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0, 1:
            let report = indexPath.section == 0 ? activeExpenseReports[indexPath.row] : submittedExpenseReports[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: FUIObjectTableViewCell.reuseIdentifier, for: indexPath) as! FUIObjectTableViewCell
            cell.headlineText = report.reportname
            cell.footnoteText = report.reportlocation
            cell.subheadlineText = report.rangeString()

            if let status = report.reportstatusid {
                switch status.trimmingCharacters(in: .whitespaces) {
                case "PEN":
                    cell.statusText = "Pending"
                    cell.statusLabel.textColor = UIColor.preferredFioriColor(forStyle: .critical)
                case "APP":
                    cell.statusText = "Approved"
                    cell.statusLabel.textColor = UIColor.preferredFioriColor(forStyle: .positive)
                case "REJ":
                    cell.statusText = "Rejected"
                    cell.statusLabel.textColor = UIColor.preferredFioriColor(forStyle: .negative)
                case "ACT":
                    cell.statusText = "Active"
                default:
                    break
                }
            }

            cell.accessoryType = .disclosureIndicator
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: FUITextFieldFormCell.reuseIdentifier, for: indexPath) as! FUITextFieldFormCell
            cell.keyLabel.text = "All Reports"
            cell.value = "\(expenseReports.count)"
            cell.accessoryType = .disclosureIndicator
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: FUITableViewHeaderFooterView.reuseIdentifier) as! FUITableViewHeaderFooterView
        view.backgroundView = UIView()
        view.backgroundView?.backgroundColor = UIColor.white
        view.isUserInteractionEnabled = false

        switch section {
        case 0:
            view.titleLabel.text = "Active"
        case 1:
            view.titleLabel.text = "Submitted"
        default:
            return nil
        }
        return view
    }

    // MARK: - Table view delegate

    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section < 2 else { return }

        let report = indexPath.section == 0 ? activeExpenseReports[indexPath.row] : submittedExpenseReports[indexPath.row]

        let reportDetail = ReportDetailsTableViewController(style: .grouped)
        reportDetail.setReport(report)
        self.navigationController?.pushViewController(reportDetail, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == 0
    }
    
    // MARK: - Support submitting Expense Report
    
    override func tableView(_ tableView: UITableView,
                            leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        guard indexPath.section == 0 else {
            return nil
        }
        let submitAction = UIContextualAction(style: .normal, title:  "Submit\nReport", handler: { action, _, success in
            guard indexPath.section == 0 else { return }
            
            let entity = self.activeExpenseReports[indexPath.row]
            entity.reportstatusid = "PEN"
            
            DataHandler.shared.service.updateEntity(entity, completionHandler: { [weak self] error in
                guard error == nil else {
                    let errorBanner = FUIBannerMessageView()
                    
                    errorBanner.show(message: "Failed to submit Expense Report", withDuration: 4.0, animated: true)
                    success(false)
                    return
                }
                
                self?.tableView.beginUpdates()
                self?.tableView.deleteRows(at: [indexPath], with: .automatic)
                let item = self?.activeExpenseReports.remove(at: indexPath.row)
                self?.tableView.endUpdates()
                self?.submittedExpenseReports.append(item!)
                self?.tableView.reloadSections([1], with: .automatic)
                
                FUIToastMessage.show(message: "Submitted Expense Report: \(entity.reportname ?? "")", icon: FUIIconLibrary.system.success.withRenderingMode(.alwaysTemplate), inWindow: nil, withDuration: 1.5 , maxNumberOfLines: 2)
                success(true)
            })
        })
        submitAction.backgroundColor = UIColor.preferredFioriColor(forStyle: .map1)
        return UISwipeActionsConfiguration(actions: [submitAction])
        
    }


    // MARK: - Actions
    
    func reloadReports() {
        let nestedQuery = DataQuery().expand(ExpenseItem.currency, ExpenseItem.expenseType, ExpenseItem.paymentType, ExpenseItem.attachments).orderBy(ExpenseItem.itemdate)
        let query = DataQuery().expand(ExpenseReportItem.expenseItems, withQuery: nestedQuery)
        
        DataHandler.shared.service.fetchExpenseReports(matching: query) { [weak self] entities, error in
            guard let entities = entities else {
                return print(String(describing: error))
            }
            self?.expenseReports = entities
        }
    }

    @objc func toggleEditing() {
        self.setEditing(!self.isEditing, animated: true)
    }

    @objc func addReport() {
        let vc = CreateReportTableViewController(style: .grouped)
        let navigationController = UINavigationController(rootViewController: vc)
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
}
