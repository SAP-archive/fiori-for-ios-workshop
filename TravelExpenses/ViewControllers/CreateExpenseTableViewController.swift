//
//  CreateExpenseTableViewController.swift
//  SAP-Expense
//
//  Created by Stadelman, Stan on 4/22/18.
//  Copyright © 2018 SAP SE or an SAP affiliate company.  All rights reserved.
//

import MobileCoreServices
import Photos
import SAPFiori
import SAPOData
import UIKit

class CreateExpenseTableViewController: FUIFormTableViewController {
    private var modalProcessingView: FUIModalProcessingIndicatorView?
    
    // MARK: - Model

    // Newly created Expense Item
    let expense = ExpenseItem()

    // Data sources for list picker rows
    let currencyPickerDataSource = CurrencyPickerDataSource()
    let reportsPickerDataSource = ReportsPickerDataSource()
    let expenseTypePickerDataSource = ExpenseTypePickerDataSource()
    let paymentTypePickerDataSource = PaymentTypePickerDataSource()

    private(set) var attachmentURLs: [URL] = []
    private(set) var attachmentThumbnails: [URL: UIImage?] = [:] {
        didSet {
            DispatchQueue.main.async {
                self.attachmentController?.reloadData()
                self.tableView.beginUpdates()
                self.tableView.endUpdates()
            }
        }
    }

    weak var attachmentController: FUIAttachmentsViewController?

    // MARK: View controller hooks

    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure table view
        self.title = "Create Expense"
        self.tableView.estimatedRowHeight = 44
        self.tableView.rowHeight = UITableView.automaticDimension

        // Register cell classes
        self.tableView.register(FUITitleFormCell.self, forCellReuseIdentifier: FUITitleFormCell.reuseIdentifier)
        self.tableView.register(FUIListPickerFormCell.self, forCellReuseIdentifier: FUIListPickerFormCell.reuseIdentifier)
        self.tableView.register(FUIDatePickerFormCell.self, forCellReuseIdentifier: FUIDatePickerFormCell.reuseIdentifier)
        self.tableView.register(FUINoteFormCell.self, forCellReuseIdentifier: FUINoteFormCell.reuseIdentifier)
        self.tableView.register(FUIAttachmentsFormCell.self, forCellReuseIdentifier: FUIAttachmentsFormCell.reuseIdentifier)

        // Setup bar button items
        let createItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(self.saveItem))
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancel))
        self.navigationItem.leftBarButtonItem = cancelItem
        self.navigationItem.rightBarButtonItem = createItem
        

        // Set defaults for newly created expense item
        self.expense.itemid = UUID().uuidString
        self.expense.currencyid = expense.localCurrency()
        self.expense.paymenttypeid = "EMP"
        self.expense.itemdate = LocalDateTime.from(utc: Date())

        // Populate options for the list picker data sources
        do {
            try self.currencyPickerDataSource.entities = DataHandler.shared.service.fetchCurrencies()
            try self.reportsPickerDataSource.entities = DataHandler.shared.service.fetchExpenseReports()
            try self.expenseTypePickerDataSource.entities = DataHandler.shared.service.fetchExpenses()
            try self.paymentTypePickerDataSource.entities = DataHandler.shared.service.fetchPayments()
        } catch {
            print(error)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in _: UITableView) -> Int {
        return 4
    }

    override func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 6
        default:
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Utility method for configuring the table view cells displayed in the list pickers
        func applyDefaultConfiguration(forListPickerFormCell cell: FUIListPickerFormCell, dataSource: FUIListPickerDataSource) {
            cell.listPicker.register(FUIObjectTableViewCell.self, forCellReuseIdentifier: FUIObjectTableViewCell.reuseIdentifier)
            cell.listPicker.dataSource = dataSource
            cell.listPicker.isDataSourceRequiringUniqueIdentifiers = true
            cell.allowsEmptySelection = false
            cell.allowsMultipleSelection = false
        }

        switch (indexPath.section, indexPath.row) {
        // Setup editable `FUITitleFormCell` for Vendor
        case (0, 0):
            let cell = tableView.dequeueReusableCell(withIdentifier: FUITitleFormCell.reuseIdentifier, for: indexPath) as! FUITitleFormCell

            cell.placeholderText = "Vendor"
            cell.valueTextField.text = self.expense.vendor

            cell.onChangeHandler = { [weak self, weak cell] in
                self?.expense.vendor = $0

                let validationMessage = self?.expense.validationMessage(for: \.vendor)
                cell?.validationMessage = validationMessage
            }
            cell.validationMessage = self.expense.validationMessage(for: \.vendor)
            return cell

        // Setup editable `FUITitleFormCell` for Amount
        case (0, 1):
            let cell = tableView.dequeueReusableCell(withIdentifier: FUITitleFormCell.reuseIdentifier, for: indexPath) as! FUITitleFormCell

            let numberFormatter = NumberFormatter(.currency)
            numberFormatter.currencyCode = self.expense.currencyid ?? self.expense.localCurrency()
            if let amount = self.expense.amount?.doubleValue() {
                cell.valueTextField.text = numberFormatter.string(from: amount as NSNumber)
            } else {
                cell.placeholderText = numberFormatter.string(from: 0 as NSNumber)
            }

            cell.valueTextField.delegate = self
            cell.valueTextField.keyboardType = .decimalPad
            cell.valueTextField.returnKeyType = .done
            cell.valueTextField.addDoneButtonToKeyboard()

            cell.onChangeHandler = { [weak self, weak cell] in
                // The changed value may contain currency formatting, so handle both raw and formatted cases
                // NOTE: hitting enter in field gives raw value, tabbing out of field gives formatted
                if let value = numberFormatter.number(from: $0) {
                    self?.expense.amount = BigDecimal(value.decimalValue)
                } else if let value = BigDecimal.parse($0)  {
                    self?.expense.amount = value
                } else {
                    self?.expense.amount = BigDecimal(0)
                }

                let validationMessage = self?.expense.validationMessage(for: \.amount)
                cell?.validationMessage = validationMessage
            }
            cell.validationMessage = self.expense.validationMessage(for: \.amount)
            return cell

        // Setup editable `FUIListPickerFormCell` for Currency selection
        case (1, 0):
            let cell = tableView.dequeueReusableCell(withIdentifier: FUIListPickerFormCell.reuseIdentifier, for: indexPath) as! FUIListPickerFormCell
            applyDefaultConfiguration(forListPickerFormCell: cell, dataSource: currencyPickerDataSource)

            cell.keyName = "Currency"

            let uuidValues: [String] = {
                guard let currencyid = expense.currencyid, !currencyid.isEmpty else { return [] }
                return [currencyid]
            }()

            cell.uuidValues = uuidValues

            let entity = currencyPickerDataSource.singleEntity(for: uuidValues)
            cell.valueTextField.text = entity?.currencyid
            cell.validationMessage = self.expense.validationMessage(for: \.currencyid)

            cell.onUuidChangeHandler = { [unowned self] in
                let entity = self.currencyPickerDataSource.singleEntity(for: $0)
                self.expense.currencyid = entity?.currencyid

                // MARK: - Special case:  since this value affects formatting of Amount, reload the Amount row
                DispatchQueue.main.async {
                    self.tableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .none)
                }
            }
            return cell

        // Setup editable `FUIListPickerFormCell` for Expense Type selection
        case (1, 1):
            let cell = tableView.dequeueReusableCell(withIdentifier: FUIListPickerFormCell.reuseIdentifier, for: indexPath) as! FUIListPickerFormCell
            applyDefaultConfiguration(forListPickerFormCell: cell, dataSource: expenseTypePickerDataSource)

            cell.keyName = "Expense Type"

            let uuidValues: [String] = {
                guard let expensetypeid = expense.expensetypeid, !expensetypeid.isEmpty else { return [] }
                return [expensetypeid]
            }()

            cell.uuidValues = uuidValues

            let entity = expenseTypePickerDataSource.singleEntity(for: uuidValues)
            cell.valueTextField.text = entity?.description
            cell.validationMessage = self.expense.validationMessage(for: \.expensetypeid)

            cell.onUuidChangeHandler = { [weak self] in
                let entity = self?.expenseTypePickerDataSource.singleEntity(for: $0)
                self?.expense.expensetypeid = entity?.expensetypeid
            }
            return cell

        // Setup editable `FUIListPickerFormCell` for Location selection
        case (1, 2):
            let cell = tableView.dequeueReusableCell(withIdentifier: FUIListPickerFormCell.reuseIdentifier, for: indexPath) as! FUIListPickerFormCell
            cell.keyName = "Location"
            cell.valueOptions = Array(Set(reportsPickerDataSource.entities.compactMap { $0.reportlocation }))
            cell.allowsEmptySelection = false
            cell.allowsMultipleSelection = false
            cell.onChangeHandler = { [weak self, weak cell] in
                self?.expense.location = cell?.valueOptions[$0.first!]
            }
            cell.value = { [weak self, weak cell] in
                guard let location = self?.expense.location, let index = cell?.valueOptions.index(of: location) else { return [] }
                return [index]
            }()
            return cell

        // Setup editable `FUIDatePickerFormCell` for item Date selection
        case (1, 3):
            let cell = tableView.dequeueReusableCell(withIdentifier: FUIDatePickerFormCell.reuseIdentifier, for: indexPath) as! FUIDatePickerFormCell
            cell.keyName = "Date"
            if let itemDate = self.expense.itemdate {
                cell.value = itemDate.utc()
            } else {
                cell.value = Date()
            }
            cell.datePickerMode = .date
            cell.onChangeHandler = { [weak self] in
                self?.expense.itemdate = LocalDateTime.from(utc: $0)
            }
            return cell

        // Setup editable `FUIListPickerFormCell` for Report selection
        case (1, 4):
            let cell = tableView.dequeueReusableCell(withIdentifier: FUIListPickerFormCell.reuseIdentifier, for: indexPath) as! FUIListPickerFormCell
            applyDefaultConfiguration(forListPickerFormCell: cell, dataSource: reportsPickerDataSource)

            cell.keyName = "Report"

            let uuidValues: [String] = {
                guard let reportId = expense.reportid, !reportId.isEmpty else { return [] }
                return [reportId]
            }()

            cell.uuidValues = uuidValues

            let entity = reportsPickerDataSource.singleEntity(for: uuidValues)
            cell.valueTextField.text = entity?.reportname
            cell.validationMessage = self.expense.validationMessage(for: \.reportid)

            cell.onUuidChangeHandler = { [weak self] in
                let entity = self?.reportsPickerDataSource.singleEntity(for: $0)
                self?.expense.reportid = entity?.reportid
            }
            return cell

        // Setup editable `FUIListPickerFormCell` for Payment Type selection
        case (1, 5):
            let cell = tableView.dequeueReusableCell(withIdentifier: FUIListPickerFormCell.reuseIdentifier, for: indexPath) as! FUIListPickerFormCell
            applyDefaultConfiguration(forListPickerFormCell: cell, dataSource: paymentTypePickerDataSource)

            cell.keyName = "Payment Type"

            let uuidValues: [String] = {
                guard let paymenttypeid = expense.paymenttypeid, !paymenttypeid.isEmpty else { return [] }
                return [paymenttypeid]
            }()

            cell.uuidValues = uuidValues

            let entity = paymentTypePickerDataSource.singleEntity(for: uuidValues)
            cell.valueTextField.text = entity?.description
            cell.validationMessage = self.expense.validationMessage(for: \.paymenttypeid)

            cell.onUuidChangeHandler = { [weak self] in
                let entity = self?.paymentTypePickerDataSource.singleEntity(for: $0)
                self?.expense.paymenttypeid = entity?.paymenttypeid
            }
            return cell

        // Setup editable `FUINoteFormCell` for adding Comments
        case (2, 0):
            let cell = tableView.dequeueReusableCell(withIdentifier: FUINoteFormCell.reuseIdentifier, for: indexPath) as! FUINoteFormCell
            cell.placeholderText = "Add Comment"
            cell.value = expense.notes ?? ""
            cell.onChangeHandler = { [weak self] in
                self?.expense.notes = $0
            }
            return cell

        // Setup editable `FUIAttachmentsFormCell` for adding receipt Images
        case (3, 0):
            let cell = tableView.dequeueReusableCell(withIdentifier: FUIAttachmentsFormCell.reuseIdentifier, for: indexPath) as! FUIAttachmentsFormCell
            self.attachmentController = cell.attachmentsController
            cell.attachmentsController.dataSource = self
            cell.attachmentsController.delegate = self
            cell.attachmentsController.customAttachmentsTitleFormat = "Receipts (%d)"

            let addPhotoAction = FUIAddPhotoAttachmentAction()
            addPhotoAction.delegate = self
            cell.attachmentsController.addAttachmentAction(addPhotoAction)

            let takePhotoAction = FUITakePhotoAttachmentAction()
            takePhotoAction.delegate = self
            cell.attachmentsController.addAttachmentAction(takePhotoAction)

            if #available(iOS 11.0, *) {
                let dropInteraction = UIDropInteraction(delegate: self)
                attachmentController?.view.addInteraction(dropInteraction)
            } else {
                // Fallback on earlier versions
            }
            
            cell.attachmentsController.reloadData()

            return cell
        default:
            return UITableViewCell()
        }
    }

    // MARK: - Actions

    @objc func cancel() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc func saveItem() {
        guard let _ = expense.vendor else {
            return FUIToastMessage.show(message: "Please specify a Vendor")
        }
        guard let _ = expense.currencyid else {
            return FUIToastMessage.show(message: "Please select a Currency")
        }
        guard let _ = expense.reportid else {
            return FUIToastMessage.show(message: "Please link expense to a Report")
        }
        guard let _ = expense.expensetypeid else {
            return FUIToastMessage.show(message: "Please select an Expense Type")
        }
        guard let _ = expense.paymenttypeid else {
            return FUIToastMessage.show(message: "Please specify a Payment Type")
        }

        
        guard attachmentURLs.count > 0 else {
            saveToOData(imageNames: [])
            
            return
        }
        
        self.modalProcessingView = FUIModalProcessingIndicator.show(inView: self.view)
        DispatchQueue.global().async {
            let imageHandler = ImageHandler.shared()
            
            imageHandler.uploadImages(imageUrls: self.attachmentURLs, completion: { (imageNames, error) in
                DispatchQueue.main.async {
                    self.modalProcessingView?.dismiss()
                    
                    if let error = error {
                        print("error uploading: \(error.localizedDescription)")
                        
                        let errorBanner = FUIBannerMessageView()
                        
                        errorBanner.show(message: "Failed to upload image", withDuration: 3.0, animated: true)
                        
                        return
                    }
                    
                    self.saveToOData(imageNames: imageNames)
                }
            })
        }
    }

    
    // MARK: - Utility methods
    private func saveToOData(imageNames: [String]) {
        do {
            let reportQuery = DataQuery().withKey(ExpenseReportItem.key(reportid: self.expense.reportid!))
            let report = try Single.required(DataHandler.shared.service.fetchExpenseReports(matching: reportQuery))
            
            let changeSet = ChangeSet()
            changeSet.createEntity(self.expense)
            
            for imageName in imageNames {
                let attachment = ExpenseItemAttachment()
                attachment.attachmentid = imageName
                attachment.name = "\(imageName).jpg"
                attachment.reportid = report.reportid
                attachment.itemid = self.expense.itemid
                
                changeSet.createEntity(attachment)
                changeSet.createLink(from: attachment, property: ExpenseItemAttachment.expenseItem, to: self.expense)
            }
            
            if report.reportstatusid != "ACT" {
                report.reportstatusid = "ACT"
                changeSet.updateEntity(report)
            }
            try DataHandler.shared.service.applyChanges(changeSet)
            
        } catch {
            print(error)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    // Utility method, for adding attachment to the local data model
    func addAttachmentURL(_ url: URL, withThumbnail thumbnail: UIImage) {
        if !self.attachmentURLs.contains(url) { self.attachmentURLs.append(url) }
        self.attachmentThumbnails.updateValue(thumbnail, forKey: url)
        DispatchQueue.main.async {
            self.attachmentController?.reloadData()
            
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
    }

    // Utility method, for removing attachment from the local data model
    func removeAttachment(at index: Int) {
        let url = attachmentURLs.remove(at: index)
        attachmentThumbnails.removeValue(forKey: url)
    }

    // Utility method, for accessing Photos images
    func addPHAsset(_ asset: PHAsset, atURL url: URL) {
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        options.version = .current

        manager.requestImage(for: asset, targetSize: CGSize(width: 64, height: 64), contentMode: .aspectFill, options: options) { [weak self] image, _ in
            guard let image = image else { return }
            self?.addAttachmentURL(url, withThumbnail: image)
        }
    }
}

// MARK: - Attachments data source & delegate

extension CreateExpenseTableViewController: FUIAttachmentsViewControllerDataSource, FUIAttachmentsViewControllerDelegate {
    func numberOfAttachments(in _: FUIAttachmentsViewController) -> Int {
        return self.attachmentURLs.count
    }

    func attachmentsViewController(_: FUIAttachmentsViewController, iconForAttachmentAtIndex index: Int) -> (image: UIImage, contentMode: UIView.ContentMode)? {
        let url = self.attachmentURLs[index]
        guard let image = self.attachmentThumbnails[url] else {
            return nil
        }
        return (image!, .scaleAspectFill)
    }

    func attachmentsViewController(_: FUIAttachmentsViewController, urlForAttachmentAtIndex index: Int) -> URL? {
        return self.attachmentURLs[index]
    }

    func attachmentsViewController(_: FUIAttachmentsViewController, didPressDeleteAtIndex index: Int) {
        self.attachmentURLs.remove(at: index)
    }

    func attachmentsViewController(_: FUIAttachmentsViewController, couldNotPresentAttachmentAtIndex _: Int) {
        let alertController = UIAlertController(title: "Attachment Unavailable", message: "Cannot read attachment. It might not be downloaded on device", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel) { [weak alertController] _ in
            alertController?.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(action)
        navigationController?.present(alertController, animated: true, completion: nil)
    }
}

// MARK: - Get photo from Camera

extension CreateExpenseTableViewController: FUITakePhotoAttachmentActionDelegate {
    func takePhotoAttachmentAction(_: FUITakePhotoAttachmentAction, didTakePhoto asset: PHAsset, at url: URL) {
        self.addPHAsset(asset, atURL: url)
    }
}

// MARK: - Get photo from Photo Roll

extension CreateExpenseTableViewController: FUIAddPhotoAttachmentActionDelegate {
    func addPhotoAttachmentAction(_: FUIAddPhotoAttachmentAction, didSelectPhoto asset: PHAsset, at url: URL) {
        self.addPHAsset(asset, atURL: url)
    }
}

// MARK: - Drop interaction handler for Attachments view

@available(iOS 11.0, *)
extension CreateExpenseTableViewController: UIDropInteractionDelegate {
    func dropInteraction(_: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.hasItemsConforming(toTypeIdentifiers: [kUTTypeImage as String, kCFURLTypeIdentifierKey as String]) && session.items.count == 1
    }

    func dropInteraction(_: UIDropInteraction, sessionDidUpdate _: UIDropSession) -> UIDropProposal {
        // Propose to the system to copy the item from the source app
        return UIDropProposal(operation: .copy)
    }

    func dropInteraction(_: UIDropInteraction, performDrop session: UIDropSession) {
        // Consume drag items (in this example, of type UIImage).
        session.loadObjects(ofClass: UIImage.self) { imageItems in
            let images = imageItems as! [UIImage]
            print("images: \(images)")
            self.addAttachmentURL(URL(string: "http://something.com")!, withThumbnail: images.first!)
//            self.imageView.image = images.first
        }
        // Perform additional UI updates as needed.
    }
}

// MARK: - Formatting delegate for Amount row

extension CreateExpenseTableViewController: UITextFieldDelegate {
    // Setting text here does not invoke the change handler, allowing formatting once the value is entered by end-user
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, let number = Double(text) {
            let numberFormatter = NumberFormatter(.currency)
            numberFormatter.currencyCode = self.expense.currencyid ?? "USD"
            textField.text = numberFormatter.string(from: number as NSNumber)
        }
    }
}
