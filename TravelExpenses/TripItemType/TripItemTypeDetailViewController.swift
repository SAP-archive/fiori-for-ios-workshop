//
// TripItemTypeDetailViewController.swift
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

class TripItemTypeDetailViewController: FUIFormTableViewController, SAPFioriLoadingIndicator {
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var travelexpense: Travelexpense<OfflineODataProvider> {
        return self.appDelegate.travelexpense
    }

    private var validity = [String: Bool]()
    private var _entity: TripItemType?
    var allowsEditableCells = false
    var entity: TripItemType {
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

    private let logger = Logger.shared(named: "TripItemTypeMasterViewControllerLogger")
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
            let detailViewController = dest.viewControllers[0] as! TripItemTypeDetailViewController
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
            return self.cellForTripid(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: TripItemType.tripid)
        case 1:
            return self.cellForDescription(tableView: tableView, indexPath: indexPath, currentEntity: self.entity, property: TripItemType.description)
        case 2:
            let cell = CellCreationHelper.cellForDefault(tableView: tableView, indexPath: indexPath, editingIsAllowed: false)
            cell.keyName = "Reservations"
            cell.value = " "
            cell.accessoryType = .disclosureIndicator
            return cell
        default:
            return UITableViewCell()
        }
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 3
    }

    override func tableView(_: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row < 2 {
            return true
        }
        return false
    }

    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.preventNavigationLoop {
            return
        }
        switch indexPath.row {
        case 2:
            self.showFioriLoadingIndicator()
            let destinationStoryBoard = UIStoryboard(name: "ReservationItemType", bundle: nil)
            var masterViewController = destinationStoryBoard.instantiateViewController(withIdentifier: "ReservationItemTypeMaster")
            func loadProperty(_ completionHandler: @escaping ([ReservationItemType]?, Error?) -> Void) {
                self.travelexpense.loadProperty(TripItemType.reservations, into: self.entity) { error in
                    self.hideFioriLoadingIndicator()
                    if let error = error {
                        completionHandler(nil, error)
                        return
                    }
                    completionHandler(self.entity.reservations, nil)
                }
            }
            (masterViewController as! ReservationItemTypeMasterViewController).loadEntitiesBlock = loadProperty
            masterViewController.navigationItem.title = "Reservations"
            (masterViewController as! ReservationItemTypeMasterViewController).preventNavigationLoop = true
            self.navigationController?.pushViewController(masterViewController, animated: true)
        default:
            return
        }
    }

    // MARK: - OData property specific cell creators

    private func cellForTripid(tableView: UITableView, indexPath: IndexPath, currentEntity: TripItemType, property: Property) -> UITableViewCell {
        var value = ""
        value = "\(currentEntity.tripid ?? "")"
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            if TripItemType.tripid.isOptional || newValue != "" {
                currentEntity.tripid = newValue
                isNewValueValid = true
            }
            self.validity[property.name] = isNewValueValid
            self.barButtonShouldBeEnabled()
            return isNewValueValid
        })
    }

    private func cellForDescription(tableView: UITableView, indexPath: IndexPath, currentEntity: TripItemType, property: Property) -> UITableViewCell {
        var value = ""
        if let propertyValue = currentEntity.description {
            value = "\(propertyValue)"
        }
        return CellCreationHelper.cellForProperty(tableView: tableView, indexPath: indexPath, entity: self.entity, property: property, value: value, editingIsAllowed: self.allowsEditableCells, changeHandler: { (newValue: String) -> Bool in
            var isNewValueValid = false
            // The property is optional, so nil value can be accepted
            if newValue.isEmpty {
                currentEntity.description = nil
                isNewValueValid = true
            } else {
                if TripItemType.description.isOptional || newValue != "" {
                    currentEntity.description = newValue
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

    func createEntityWithDefaultValues() -> TripItemType {
        let newEntity = TripItemType()
        // Fill the mandatory properties with default values
        newEntity.tripid = CellCreationHelper.defaultValueFor(TripItemType.tripid)

        // Key properties without default value should be invalid by default for Create scenario
        if newEntity.tripid == nil || newEntity.tripid!.isEmpty {
            self.validity["TRIPID"] = false
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

extension TripItemTypeDetailViewController: EntityUpdaterDelegate {
    func entityHasChanged(_ entityValue: EntityValue?) {
        if let entity = entityValue {
            let currentEntity = entity as! TripItemType
            self.entity = currentEntity
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
}
