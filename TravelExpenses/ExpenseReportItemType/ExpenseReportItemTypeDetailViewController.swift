//
// ExpenseReportItemTypeDetailViewController.swift
// TravelExpenses
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 09/06/18
//

import Foundation
import SAPCommon
import SAPFiori
import SAPFoundation
import SAPOData
import SAPOfflineOData

class ExpenseReportItemTypeDetailViewController: FUIFormTableViewController, SAPFioriLoadingIndicator {
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var travelexpense: Travelexpense<OfflineODataProvider> {
        return self.appDelegate.travelexpense
    }

    private var validity = [String: Bool]()
    private var _entity: ExpenseReportItemType?
    var allowsEditableCells = false
    var entity: ExpenseReportItemType {
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

    private let logger = Logger.shared(named: "ExpenseReportItemTypeMasterViewControllerLogger")
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
            let detailViewController = dest.viewControllers[0] as! ExpenseReportItemTypeDetailViewController
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
            return self.cellForReportid(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: ExpenseReportItemType.reportid)
        case 1:
            return self.cellForReportname(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: ExpenseReportItemType.reportname)
        case 2:
            return self.cellForReportstart(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: ExpenseReportItemType.reportstart)
        case 3:
            return self.cellForReportend(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: ExpenseReportItemType.reportend)
        case 4:
            return self.cellForReportlocation(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: ExpenseReportItemType.reportlocation)
        case 5:
            return self.cellForReportstatusid(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: ExpenseReportItemType.reportstatusid)
        case 6:
            let cell = CellCreationHelper.cellForDefault(tableView: tableView, indexPath: indexPath, editingIsAllowed: false)
            cell.keyName = "ExpenseItems"
            cell.value = " "
            cell.accessoryType = .disclosureIndicator
            return cell
        case 7:
            let cell = CellCreationHelper.cellForDefault(tableView: tableView, indexPath: indexPath, editingIsAllowed: false)
            cell.keyName = "ReportStatus"
            cell.value = " "
            cell.accessoryType = .disclosureIndicator
            return cell
        default:
            return UITableViewCell()
        }
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 8
    }

    override func tableView(_: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row < 6 {
            return true
        }
        return false
    }

    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.preventNavigationLoop {
            return
        }
        switch indexPath.row {
        case 6:
            self.showFioriLoadingIndicator()
            let destinationStoryBoard = UIStoryboard(name: "ExpenseItemType", bundle: nil)
            var masterViewController = destinationStoryBoard.instantiateViewController(withIdentifier: "ExpenseItemTypeMaster")
            func loadProperty(_ completionHandler: @escaping ([ExpenseItemType]?, Error?) -> Void) {
                self.travelexpense.loadProperty(ExpenseReportItemType.expenseItems, into: self.entity) { error in
                    self.hideFioriLoadingIndicator()
                    if let error = error {
                        completionHandler(nil, error)
                        return
                    }
                    completionHandler(self.entity.expenseItems, nil)
                }
            }
            (masterViewController as! ExpenseItemTypeMasterViewController).loadEntitiesBlock = loadProperty
            masterViewController.navigationItem.title = "ExpenseItems"
            (masterViewController as! ExpenseItemTypeMasterViewController).preventNavigationLoop = true
            self.navigationController?.pushViewController(masterViewController, animated: true)
        case 7:
            self.showFioriLoadingIndicator()
            let destinationStoryBoard = UIStoryboard(name: "ReportStatusType", bundle: nil)
            let destinationDetailVC = destinationStoryBoard.instantiateViewController(withIdentifier: "ReportStatusTypeDetailViewController") as! ReportStatusTypeDetailViewController
            self.travelexpense.loadProperty(ExpenseReportItemType.reportStatus, into: self.entity) { error in
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
                if let reportStatus = self.entity.reportStatus {
                    destinationDetailVC.entity = reportStatus
                }
                destinationDetailVC.navigationItem.leftItemsSupplementBackButton = true
                destinationDetailVC.navigationItem.title = "ReportStatus"
                destinationDetailVC.allowsEditableCells = false
                destinationDetailVC.preventNavigationLoop = true
                self.navigationController?.pushViewController(destinationDetailVC, animated: true)
            }
        default:
            return
        }
    }

    // MARK: - OData property specific cell creators

    private func cellForReportid(tableView: UITableView, indexPath: IndexPath, currentEntity: ExpenseReportItemType, property: Property) -> UITableViewCell {
        var value = ""
        value = "\(currentEntity.reportid ?? "")"
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            if ExpenseReportItemType.reportid.isOptional || newValue != "" {
                currentEntity.reportid = newValue
                isNewValueValid = true
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForReportname(tableView: UITableView, indexPath: IndexPath, currentEntity: ExpenseReportItemType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.reportname {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.reportname = nil
                isNewValueValid = true
            } else {
                if ExpenseReportItemType.reportname.isOptional || newValue != "" {
                    currentEntity.reportname = newValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForReportstart(tableView: UITableView, indexPath: IndexPath, currentEntity: ExpenseReportItemType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.reportstart {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.reportstart = nil
                isNewValueValid = true
            } else {
                if let validValue = LocalDateTime.parse(newValue) { // This is just a simple solution to handle UTC only
                    currentEntity.reportstart = validValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForReportend(tableView: UITableView, indexPath: IndexPath, currentEntity: ExpenseReportItemType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.reportend {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.reportend = nil
                isNewValueValid = true
            } else {
                if let validValue = LocalDateTime.parse(newValue) { // This is just a simple solution to handle UTC only
                    currentEntity.reportend = validValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForReportlocation(tableView: UITableView, indexPath: IndexPath, currentEntity: ExpenseReportItemType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.reportlocation {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.reportlocation = nil
                isNewValueValid = true
            } else {
                if ExpenseReportItemType.reportlocation.isOptional || newValue != "" {
                    currentEntity.reportlocation = newValue
                    isNewValueValid = true
                }
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForReportstatusid(tableView: UITableView, indexPath: IndexPath, currentEntity: ExpenseReportItemType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.reportstatusid {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.reportstatusid = nil
                isNewValueValid = true
            } else {
                if ExpenseReportItemType.reportstatusid.isOptional || newValue != "" {
                    currentEntity.reportstatusid = newValue
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

    func createEntityWithDefaultValues() -> ExpenseReportItemType {
        let newEntity = ExpenseReportItemType()
        // Fill the mandatory properties with default values
        newEntity.reportid = CellCreationHelper.defaultValueFor(ExpenseReportItemType.reportid)

        // Key properties without default value should be invalid by default for Create scenario
        if newEntity.reportid == nil || newEntity.reportid!.isEmpty {
            self.validity["REPORTID"] = false
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

extension ExpenseReportItemTypeDetailViewController: EntityUpdaterDelegate {
    func entityHasChanged(_ entityValue: EntityValue?) {
        if let entity = entityValue {
            let currentEntity = entity as! ExpenseReportItemType
            self.entity = currentEntity
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
}
