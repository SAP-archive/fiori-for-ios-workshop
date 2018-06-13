//
// CollectionsViewController.swift
// TravelExpenses
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 09/06/18
//

import Foundation
import SAPFiori
import SAPOData

protocol EntityUpdaterDelegate {
    func entityHasChanged(_ entity: EntityValue?)
}

protocol EntitySetUpdaterDelegate {
    func entitySetHasChanged()
}

class CollectionsViewController: FUIFormTableViewController {
    private var collections = CollectionType.all

    // Variable to store the selected index path
    private var selectedIndex: IndexPath?

    private let appDelegate = UIApplication.shared.delegate as! AppDelegate

    private let okTitle = NSLocalizedString("keyOkButtonTitle",
                                            value: "OK",
                                            comment: "XBUT: Title of OK button.")

    var isPresentedInSplitView: Bool {
        return !(self.splitViewController?.isCollapsed ?? true)
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize = CGSize(width: 320, height: 480)

        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.makeSelection()
    }

    override func viewWillTransition(to _: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: nil, completion: { _ in
            let isNotInSplitView = !self.isPresentedInSplitView
            self.tableView.visibleCells.forEach { cell in
                // To refresh the disclosure indicator of each cell
                cell.accessoryType = isNotInSplitView ? .disclosureIndicator : .none
            }
            self.makeSelection()
        })
    }

    // MARK: - UITableViewDelegate

    override func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return self.collections.count
    }

    override func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 44
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FUIObjectTableViewCell.reuseIdentifier, for: indexPath) as! FUIObjectTableViewCell
        cell.headlineLabel.text = self.collections[indexPath.row].rawValue
        cell.accessoryType = !self.isPresentedInSplitView ? .disclosureIndicator : .none
        cell.isMomentarySelection = false
        return cell
    }

    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath
        self.collectionSelected(at: indexPath)
    }

    // CollectionType selection helper

    private func collectionSelected(at: IndexPath) {
        // Load the EntityType specific ViewController from the specific storyboard
        var masterViewController: UIViewController!
        switch self.collections[at.row] {
        case .payment:
            let paymentTypeStoryBoard = UIStoryboard(name: "PaymentType", bundle: nil)
            masterViewController = paymentTypeStoryBoard.instantiateViewController(withIdentifier: "PaymentTypeMaster")
            (masterViewController as! PaymentTypeMasterViewController).entitySetName = "Payment"
            func fetchPayment(_ completionHandler: @escaping ([PaymentType]?, Error?) -> Void) {
                // Only request the first 20 values. If you want to modify the requested entities, you can do it here.
                let query = DataQuery().selectAll().top(20)
                do {
                    self.appDelegate.travelexpense!.fetchPayment(matching: query) { payment, error in
                        if error == nil {
                            completionHandler(payment, nil)
                        } else {
                            completionHandler(nil, error)
                        }
                    }
                }
            }
            (masterViewController as! PaymentTypeMasterViewController).loadEntitiesBlock = fetchPayment
            masterViewController.navigationItem.title = "PaymentType"
        case .reservation:
            let reservationTypeStoryBoard = UIStoryboard(name: "ReservationType", bundle: nil)
            masterViewController = reservationTypeStoryBoard.instantiateViewController(withIdentifier: "ReservationTypeMaster")
            (masterViewController as! ReservationTypeMasterViewController).entitySetName = "Reservation"
            func fetchReservation(_ completionHandler: @escaping ([ReservationType]?, Error?) -> Void) {
                // Only request the first 20 values. If you want to modify the requested entities, you can do it here.
                let query = DataQuery().selectAll().top(20)
                do {
                    self.appDelegate.travelexpense!.fetchReservation(matching: query) { reservation, error in
                        if error == nil {
                            completionHandler(reservation, nil)
                        } else {
                            completionHandler(nil, error)
                        }
                    }
                }
            }
            (masterViewController as! ReservationTypeMasterViewController).loadEntitiesBlock = fetchReservation
            masterViewController.navigationItem.title = "ReservationType"
        case .expense:
            let expenseTypeStoryBoard = UIStoryboard(name: "ExpenseType", bundle: nil)
            masterViewController = expenseTypeStoryBoard.instantiateViewController(withIdentifier: "ExpenseTypeMaster")
            (masterViewController as! ExpenseTypeMasterViewController).entitySetName = "Expense"
            func fetchExpense(_ completionHandler: @escaping ([ExpenseType]?, Error?) -> Void) {
                // Only request the first 20 values. If you want to modify the requested entities, you can do it here.
                let query = DataQuery().selectAll().top(20)
                do {
                    self.appDelegate.travelexpense!.fetchExpense(matching: query) { expense, error in
                        if error == nil {
                            completionHandler(expense, nil)
                        } else {
                            completionHandler(nil, error)
                        }
                    }
                }
            }
            (masterViewController as! ExpenseTypeMasterViewController).loadEntitiesBlock = fetchExpense
            masterViewController.navigationItem.title = "ExpenseType"
        case .expenseItem:
            let expenseItemTypeStoryBoard = UIStoryboard(name: "ExpenseItemType", bundle: nil)
            masterViewController = expenseItemTypeStoryBoard.instantiateViewController(withIdentifier: "ExpenseItemTypeMaster")
            (masterViewController as! ExpenseItemTypeMasterViewController).entitySetName = "ExpenseItem"
            func fetchExpenseItem(_ completionHandler: @escaping ([ExpenseItemType]?, Error?) -> Void) {
                // Only request the first 20 values. If you want to modify the requested entities, you can do it here.
                let query = DataQuery().selectAll().top(20)
                do {
                    self.appDelegate.travelexpense!.fetchExpenseItem(matching: query) { expenseItem, error in
                        if error == nil {
                            completionHandler(expenseItem, nil)
                        } else {
                            completionHandler(nil, error)
                        }
                    }
                }
            }
            (masterViewController as! ExpenseItemTypeMasterViewController).loadEntitiesBlock = fetchExpenseItem
            masterViewController.navigationItem.title = "ExpenseItemType"
        case .tripItem:
            let tripItemTypeStoryBoard = UIStoryboard(name: "TripItemType", bundle: nil)
            masterViewController = tripItemTypeStoryBoard.instantiateViewController(withIdentifier: "TripItemTypeMaster")
            (masterViewController as! TripItemTypeMasterViewController).entitySetName = "TripItem"
            func fetchTripItem(_ completionHandler: @escaping ([TripItemType]?, Error?) -> Void) {
                // Only request the first 20 values. If you want to modify the requested entities, you can do it here.
                let query = DataQuery().selectAll().top(20)
                do {
                    self.appDelegate.travelexpense!.fetchTripItem(matching: query) { tripItem, error in
                        if error == nil {
                            completionHandler(tripItem, nil)
                        } else {
                            completionHandler(nil, error)
                        }
                    }
                }
            }
            (masterViewController as! TripItemTypeMasterViewController).loadEntitiesBlock = fetchTripItem
            masterViewController.navigationItem.title = "TripItemType"
        case .reservationItem:
            let reservationItemTypeStoryBoard = UIStoryboard(name: "ReservationItemType", bundle: nil)
            masterViewController = reservationItemTypeStoryBoard.instantiateViewController(withIdentifier: "ReservationItemTypeMaster")
            (masterViewController as! ReservationItemTypeMasterViewController).entitySetName = "ReservationItem"
            func fetchReservationItem(_ completionHandler: @escaping ([ReservationItemType]?, Error?) -> Void) {
                // Only request the first 20 values. If you want to modify the requested entities, you can do it here.
                let query = DataQuery().selectAll().top(20)
                do {
                    self.appDelegate.travelexpense!.fetchReservationItem(matching: query) { reservationItem, error in
                        if error == nil {
                            completionHandler(reservationItem, nil)
                        } else {
                            completionHandler(nil, error)
                        }
                    }
                }
            }
            (masterViewController as! ReservationItemTypeMasterViewController).loadEntitiesBlock = fetchReservationItem
            masterViewController.navigationItem.title = "ReservationItemType"
        case .expenseReportItem:
            let expenseReportItemTypeStoryBoard = UIStoryboard(name: "ExpenseReportItemType", bundle: nil)
            masterViewController = expenseReportItemTypeStoryBoard.instantiateViewController(withIdentifier: "ExpenseReportItemTypeMaster")
            (masterViewController as! ExpenseReportItemTypeMasterViewController).entitySetName = "ExpenseReportItem"
            func fetchExpenseReportItem(_ completionHandler: @escaping ([ExpenseReportItemType]?, Error?) -> Void) {
                // Only request the first 20 values. If you want to modify the requested entities, you can do it here.
                let query = DataQuery().selectAll().top(20)
                do {
                    self.appDelegate.travelexpense!.fetchExpenseReportItem(matching: query) { expenseReportItem, error in
                        if error == nil {
                            completionHandler(expenseReportItem, nil)
                        } else {
                            completionHandler(nil, error)
                        }
                    }
                }
            }
            (masterViewController as! ExpenseReportItemTypeMasterViewController).loadEntitiesBlock = fetchExpenseReportItem
            masterViewController.navigationItem.title = "ExpenseReportItemType"
        case .currency:
            let currencyTypeStoryBoard = UIStoryboard(name: "CurrencyType", bundle: nil)
            masterViewController = currencyTypeStoryBoard.instantiateViewController(withIdentifier: "CurrencyTypeMaster")
            (masterViewController as! CurrencyTypeMasterViewController).entitySetName = "Currency"
            func fetchCurrency(_ completionHandler: @escaping ([CurrencyType]?, Error?) -> Void) {
                // Only request the first 20 values. If you want to modify the requested entities, you can do it here.
                let query = DataQuery().selectAll().top(20)
                do {
                    self.appDelegate.travelexpense!.fetchCurrency(matching: query) { currency, error in
                        if error == nil {
                            completionHandler(currency, nil)
                        } else {
                            completionHandler(nil, error)
                        }
                    }
                }
            }
            (masterViewController as! CurrencyTypeMasterViewController).loadEntitiesBlock = fetchCurrency
            masterViewController.navigationItem.title = "CurrencyType"
        case .reportStatus:
            let reportStatusTypeStoryBoard = UIStoryboard(name: "ReportStatusType", bundle: nil)
            masterViewController = reportStatusTypeStoryBoard.instantiateViewController(withIdentifier: "ReportStatusTypeMaster")
            (masterViewController as! ReportStatusTypeMasterViewController).entitySetName = "ReportStatus"
            func fetchReportStatus(_ completionHandler: @escaping ([ReportStatusType]?, Error?) -> Void) {
                // Only request the first 20 values. If you want to modify the requested entities, you can do it here.
                let query = DataQuery().selectAll().top(20)
                do {
                    self.appDelegate.travelexpense!.fetchReportStatus(matching: query) { reportStatus, error in
                        if error == nil {
                            completionHandler(reportStatus, nil)
                        } else {
                            completionHandler(nil, error)
                        }
                    }
                }
            }
            (masterViewController as! ReportStatusTypeMasterViewController).loadEntitiesBlock = fetchReportStatus
            masterViewController.navigationItem.title = "ReportStatusType"
        case .none:
            masterViewController = UIViewController()
        }

        // Load the NavigationController and present with the EntityType specific ViewController
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let rightNavigationController = mainStoryBoard.instantiateViewController(withIdentifier: "RightNavigationController") as! UINavigationController
        rightNavigationController.viewControllers = [masterViewController]
        self.splitViewController?.showDetailViewController(rightNavigationController, sender: nil)
    }

    // MARK: - Handle highlighting of selected cell

    private func makeSelection() {
        if let selectedIndex = selectedIndex {
            self.tableView.selectRow(at: selectedIndex, animated: true, scrollPosition: .none)
            self.tableView.scrollToRow(at: selectedIndex, at: .none, animated: true)
        } else {
            self.selectDefault()
        }
    }

    private func selectDefault() {
        // Automatically select first element if we have two panels (iPhone plus and iPad only)
        if self.splitViewController!.isCollapsed || self.appDelegate.travelexpense == nil {
            return
        }
        let indexPath = IndexPath(row: 0, section: 0)
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
        self.collectionSelected(at: indexPath)
    }
}
