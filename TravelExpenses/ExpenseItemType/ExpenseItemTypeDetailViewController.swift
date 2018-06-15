//
// ExpenseItemTypeDetailViewController.swift
// TravelExpenses
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 14/06/18
//

import Foundation
import SAPCommon
import SAPFiori
import SAPFoundation
import SAPOData
import SAPOfflineOData

class ExpenseItemTypeDetailViewController: FUIFormTableViewController, SAPFioriLoadingIndicator {
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var travelexpense: Travelexpense<OfflineODataProvider> {
        return self.appDelegate.travelexpense
    }

    private var validity = [String: Bool]()
    private var _entity: ExpenseItemType?
    var allowsEditableCells = false
    var entity: ExpenseItemType {
        get {
            if self._entity == nil {
                self._entity = self.createEntityWithDefaultValues()
            }
            return self._entity!
        }
        set {
            self._entity = newValue
        }
    }

    private let logger = Logger.shared(named: "ExpenseItemTypeMasterViewControllerLogger")
    var loadingIndicator: FUILoadingIndicatorView?
    var entityUpdater: EntityUpdaterDelegate?
    var tableUpdater: EntitySetUpdaterDelegate?
    private let okTitle = NSLocalizedString("keyOkButtonTitle",
                                            value: "OK",
                                            comment: "XBUT: Title of OK button.")
    var preventNavigationLoop = false
    var entitySetName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if segue.identifier == "updateEntity" {
            // Show the Detail view with the current entity, where the properties scan be edited and updated
            self.logger.info("Showing a view to update the selected entity.")
            let dest = segue.destination as! UINavigationController
            let detailViewController = dest.viewControllers[0] as! ExpenseItemTypeDetailViewController
            detailViewController.title = NSLocalizedString("keyUpdateEntityTitle", value: "Update Entity", comment: "XTIT: Title of update selected entity screen.")
            detailViewController.entity = self.entity
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: detailViewController, action: #selector(detailViewController.updateEntity))
            detailViewController.navigationItem.rightBarButtonItem = doneButton
            let cancelButton = UIBarButtonItem(title: NSLocalizedString("keyCancelButtonToGoPreviousScreen", value: "Cancel", comment: "XBUT: Title of Cancel button."), style: .plain, target: detailViewController, action: #selector(detailViewController.cancel))
            detailViewController.navigationItem.leftBarButtonItem = cancelButton
            detailViewController.allowsEditableCells = true
            detailViewController.entityUpdater = self
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return self.cellForReportid(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: ExpenseItemType.reportid)
        case 1:
            return self.cellForItemid(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: ExpenseItemType.itemid)
        case 2:
            return self.cellForExpensetypeid(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: ExpenseItemType.expensetypeid)
        case 3:
            return self.cellForItemdate(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: ExpenseItemType.itemdate)
        case 4:
            return self.cellForAmount(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: ExpenseItemType.amount)
        case 5:
            return self.cellForVendor(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: ExpenseItemType.vendor)
        case 6:
            return self.cellForLocation(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: ExpenseItemType.location)
        case 7:
            return self.cellForCurrencyid(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: ExpenseItemType.currencyid)
        case 8:
            return self.cellForNotes(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: ExpenseItemType.notes)
        case 9:
            return self.cellForPaymenttypeid(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: ExpenseItemType.paymenttypeid)
        case 10:
            let cell = CellCreationHelper.cellForDefault(tableView: tableView, indexPath: indexPath, editingIsAllowed: false)
            cell.keyName = "PaymentType"
            cell.value = " "
            cell.accessoryType = .disclosureIndicator
            return cell
        case 11:
            let cell = CellCreationHelper.cellForDefault(tableView: tableView, indexPath: indexPath, editingIsAllowed: false)
            cell.keyName = "ExpenseType"
            cell.value = " "
            cell.accessoryType = .disclosureIndicator
            return cell
        case 12:
            let cell = CellCreationHelper.cellForDefault(tableView: tableView, indexPath: indexPath, editingIsAllowed: false)
            cell.keyName = "Currency"
            cell.value = " "
            cell.accessoryType = .disclosureIndicator
            return cell
        default:
            return UITableViewCell()
        }
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 13
    }

    override func tableView(_: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row < 10 {
            return true
        }
        return false
    }

    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.preventNavigationLoop {
            return
        }
        switch indexPath.row {
        case 10:
            self.showFioriLoadingIndicator()
            let destinationStoryBoard = UIStoryboard(name: "PaymentType", bundle: nil)
            let destinationDetailVC = destinationStoryBoard.instantiateViewController(withIdentifier: "PaymentTypeDetailViewController") as! PaymentTypeDetailViewController
            self.travelexpense.loadProperty(ExpenseItemType.paymentType, into: self.entity) { error in
                self.hideFioriLoadingIndicator()
                if let error = error {
                    let alertController = UIAlertController(title: NSLocalizedString("keyErrorLoadingData", value: "Loading data failed!", comment: "XTIT: Title of loading data error pop up."), message: error.localizedDescription, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: self.okTitle, style: .default))
                    OperationQueue.main.addOperation({
                        // Present the alertController
                        self.present(alertController, animated: true)
                    })
                    return
                }
                if let paymentType = self.entity.paymentType {
                    destinationDetailVC.entity = paymentType
                }
                destinationDetailVC.navigationItem.leftItemsSupplementBackButton = true
                destinationDetailVC.navigationItem.title = "PaymentType"
                destinationDetailVC.allowsEditableCells = false
                destinationDetailVC.preventNavigationLoop = true
                self.navigationController?.pushViewController(destinationDetailVC, animated: true)
            }
        case 11:
            self.showFioriLoadingIndicator()
            let destinationStoryBoard = UIStoryboard(name: "ExpenseType", bundle: nil)
            let destinationDetailVC = destinationStoryBoard.instantiateViewController(withIdentifier: "ExpenseTypeDetailViewController") as! ExpenseTypeDetailViewController
            self.travelexpense.loadProperty(ExpenseItemType.expenseType, into: self.entity) { error in
                self.hideFioriLoadingIndicator()
                if let error = error {
                    let alertController = UIAlertController(title: NSLocalizedString("keyErrorLoadingData", value: "Loading data failed!", comment: "XTIT: Title of loading data error pop up."), message: error.localizedDescription, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: self.okTitle, style: .default))
                    OperationQueue.main.addOperation({
                        // Present the alertController
                        self.present(alertController, animated: true)
                    })
                    return
                }
                if let expenseType = self.entity.expenseType {
                    destinationDetailVC.entity = expenseType
                }
                destinationDetailVC.navigationItem.leftItemsSupplementBackButton = true
                destinationDetailVC.navigationItem.title = "ExpenseType"
                destinationDetailVC.allowsEditableCells = false
                destinationDetailVC.preventNavigationLoop = true
                self.navigationController?.pushViewController(destinationDetailVC, animated: true)
            }
        case 12:
            self.showFioriLoadingIndicator()
            let destinationStoryBoard = UIStoryboard(name: "CurrencyType", bundle: nil)
            let destinationDetailVC = destinationStoryBoard.instantiateViewController(withIdentifier: "CurrencyTypeDetailViewController") as! CurrencyTypeDetailViewController
            self.travelexpense.loadProperty(ExpenseItemType.currency, into: self.entity) { error in
                self.hideFioriLoadingIndicator()
                if let error = error {
                    let alertController = UIAlertController(title: NSLocalizedString("keyErrorLoadingData", value: "Loading data failed!", comment: "XTIT: Title of loading data error pop up."), message: error.localizedDescription, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: self.okTitle, style: .default))
                    OperationQueue.main.addOperation({
                        // Present the alertController
                        self.present(alertController, animated: true)
                    })
                    return
                }
                if let currency = self.entity.currency {
                    destinationDetailVC.entity = currency
                }
                destinationDetailVC.navigationItem.leftItemsSupplementBackButton = true
                destinationDetailVC.navigationItem.title = "Currency"
                destinationDetailVC.allowsEditableCells = false
                destinationDetailVC.preventNavigationLoop = true
                self.navigationController?.pushViewController(destinationDetailVC, animated: true)
            }
        default:
            return
        }
    }

    // MARK: - OData property specific cell creators

    private func cellForReportid(tableView: UITableView, indexPath: IndexPath, currentEntity: ExpenseItemType, property: Property) -> UITableViewCell {
        var value = ""
        value = "\(currentEntity.reportid ?? "")"
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            if ExpenseItemType.reportid.isOptional || newValue != "" {
                currentEntity.reportid = newValue
                isNewValueValid = true
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForItemid(tableView: UITableView, indexPath: IndexPath, currentEntity: ExpenseItemType, property: Property) -> UITableViewCell {
        var value = ""
        value = "\(currentEntity.itemid ?? "")"
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            if ExpenseItemType.itemid.isOptional || newValue != "" {
                currentEntity.itemid = newValue
                isNewValueValid = true
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForExpensetypeid(tableView: UITableView, indexPath: IndexPath, currentEntity: ExpenseItemType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.expensetypeid {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.expensetypeid = nil
                isNewValueValid = true
            } else {
                if ExpenseItemType.expensetypeid.isOptional || newValue != "" {
                    currentEntity.expensetypeid = newValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForItemdate(tableView: UITableView, indexPath: IndexPath, currentEntity: ExpenseItemType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.itemdate {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.itemdate = nil
                isNewValueValid = true
            } else {
                if let validValue = LocalDateTime.parse(newValue) { // This is just a simple solution to handle UTC only
                    currentEntity.itemdate = validValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForAmount(tableView: UITableView, indexPath: IndexPath, currentEntity: ExpenseItemType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.amount {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.amount = nil
                isNewValueValid = true
            } else {
                if let validValue = BigDecimal.parse(newValue) {
                    currentEntity.amount = validValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForVendor(tableView: UITableView, indexPath: IndexPath, currentEntity: ExpenseItemType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.vendor {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.vendor = nil
                isNewValueValid = true
            } else {
                if ExpenseItemType.vendor.isOptional || newValue != "" {
                    currentEntity.vendor = newValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForLocation(tableView: UITableView, indexPath: IndexPath, currentEntity: ExpenseItemType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.location {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.location = nil
                isNewValueValid = true
            } else {
                if ExpenseItemType.location.isOptional || newValue != "" {
                    currentEntity.location = newValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForCurrencyid(tableView: UITableView, indexPath: IndexPath, currentEntity: ExpenseItemType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.currencyid {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.currencyid = nil
                isNewValueValid = true
            } else {
                if ExpenseItemType.currencyid.isOptional || newValue != "" {
                    currentEntity.currencyid = newValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForNotes(tableView: UITableView, indexPath: IndexPath, currentEntity: ExpenseItemType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.notes {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.notes = nil
                isNewValueValid = true
            } else {
                if ExpenseItemType.notes.isOptional || newValue != "" {
                    currentEntity.notes = newValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForPaymenttypeid(tableView: UITableView, indexPath: IndexPath, currentEntity: ExpenseItemType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.paymenttypeid {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.paymenttypeid = nil
                isNewValueValid = true
            } else {
                if ExpenseItemType.paymenttypeid.isOptional || newValue != "" {
                    currentEntity.paymenttypeid = newValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    // MARK: - OData functionalities

    @objc func createEntity() {
        self.showFioriLoadingIndicator()
        self.view.endEditing(true)
        self.logger.info("Creating entity in backend.")
        self.travelexpense.createEntity(self.entity) { error in
            self.hideFioriLoadingIndicator()
            if let error = error {
                self.logger.error("Create entry failed. Error: \(error)", error: error)
                let alertController = UIAlertController(title: NSLocalizedString("keyErrorEntityCreationTitle", value: "Create entry failed", comment: "XTIT: Title of alert message about entity creation error."), message: error.localizedDescription, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: self.okTitle, style: .default))
                OperationQueue.main.addOperation({
                    // Present the alertController
                    self.present(alertController, animated: true)
                })
                return
            }
            self.logger.info("Create entry finished successfully.")
            OperationQueue.main.addOperation({
                self.dismiss(animated: true) {
                    FUIToastMessage.show(message: NSLocalizedString("keyEntityCreationBody", value: "Created", comment: "XMSG: Title of alert message about successful entity creation."))
                    self.tableUpdater?.entitySetHasChanged()
                }
            })
        }
    }

    func createEntityWithDefaultValues() -> ExpenseItemType {
        let newEntity = ExpenseItemType()
        // Fill the mandatory properties with default values
        newEntity.reportid = CellCreationHelper.defaultValueFor(ExpenseItemType.reportid)
        newEntity.itemid = CellCreationHelper.defaultValueFor(ExpenseItemType.itemid)

        // Key properties without default value should be invalid by default for Create scenario
        if newEntity.reportid == nil || newEntity.reportid!.isEmpty {
            self.validity["REPORTID"] = false
        }
        if newEntity.itemid == nil || newEntity.itemid!.isEmpty {
            self.validity["ITEMID"] = false
        }
        self.barButtonShouldBeEnabled()
        return newEntity
    }

    @objc func updateEntity(_: AnyObject) {
        self.showFioriLoadingIndicator()
        self.view.endEditing(true)
        self.logger.info("Updating entity in backend.")
        self.travelexpense.updateEntity(self.entity) { error in
            self.hideFioriLoadingIndicator()
            if let error = error {
                self.logger.error("Update entry failed. Error: \(error)", error: error)
                let alertController = UIAlertController(title: NSLocalizedString("keyErrorEntityUpdateTitle", value: "Update entry failed", comment: "XTIT: Title of alert message about entity update failure."), message: error.localizedDescription, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: self.okTitle, style: .default))
                OperationQueue.main.addOperation({
                    // Present the alertController
                    self.present(alertController, animated: true)
                })
                return
            }
            self.logger.info("Update entry finished successfully.")
            OperationQueue.main.addOperation({
                self.dismiss(animated: true) {
                    FUIToastMessage.show(message: NSLocalizedString("keyUpdateEntityFinishedTitle", value: "Updated", comment: "XTIT: Title of alert message about successful entity update."))
                    self.entityUpdater?.entityHasChanged(self.entity)
                }
            })
        }
    }

    // MARK: - other logic, helper

    @objc func cancel() {
        OperationQueue.main.addOperation({
            self.dismiss(animated: true)
        })
    }

    // Check if all text fields are valid
    private func barButtonShouldBeEnabled() {
        let anyFieldInvalid = self.validity.values.first { field in
            return field == false
        }
        self.navigationItem.rightBarButtonItem?.isEnabled = anyFieldInvalid == nil
    }
}

extension ExpenseItemTypeDetailViewController: EntityUpdaterDelegate {
    func entityHasChanged(_ entityValue: EntityValue?) {
        if let entity = entityValue {
            let currentEntity = entity as! ExpenseItemType
            self.entity = currentEntity
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
}
