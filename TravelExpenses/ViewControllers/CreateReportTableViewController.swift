//
//  CreateReportTableViewController.swift
//  TravelExpenses
//
//  Created by Stadelman, Stan on 6/12/18.
//  Copyright © 2018 SAP SE or an SAP affiliate company.  All rights reserved.
//

import UIKit
import SAPFiori
import SAPOData

class CreateReportTableViewController: FUIFormTableViewController {

    // MARK: - Model
    
    // Newly created Report Item
    let report = ExpenseReportItemType()
    
    // Data sources for list picker rows
    let reportStatusPickerDataSource = ReportStatusPickerDataSource()
    
    // MARK: View controller hooks
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure table view
        self.title = "Create Report"
        self.tableView.estimatedRowHeight = 44
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        // Register cell classes
        self.tableView.register(FUITitleFormCell.self, forCellReuseIdentifier: FUITitleFormCell.reuseIdentifier)
        self.tableView.register(FUIListPickerFormCell.self, forCellReuseIdentifier: FUIListPickerFormCell.reuseIdentifier)
        self.tableView.register(FUIDatePickerFormCell.self, forCellReuseIdentifier: FUIDatePickerFormCell.reuseIdentifier)
        self.tableView.register(FUINoteFormCell.self, forCellReuseIdentifier: FUINoteFormCell.reuseIdentifier)
        
        // Setup bar button items
        let createItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveItem))
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        self.navigationItem.leftBarButtonItem = cancelItem
        self.navigationItem.rightBarButtonItem = createItem
        
        // Set defaults for newly created report item
        report.reportid = UUID().uuidString
        report.reportstart = LocalDateTime.from(utc: Date())
        report.reportend = LocalDateTime.from(utc: Date().addingTimeInterval(86400))
        report.reportstatusid = "ACT"
        
        // Populate options for the list picker data sources
        do {
            try reportStatusPickerDataSource.entities = DataHandler.shared.service.fetchReportStatus()
        }
        catch {
            print(error)
        }
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 2:
            return 2
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
            
        // Setup editable `FUITitleFormCell` for Report Name
        case (0, 0):
            let cell = tableView.dequeueReusableCell(withIdentifier: FUITitleFormCell.reuseIdentifier, for: indexPath) as! FUITitleFormCell
            
            cell.placeholderText = "Report name"
            cell.valueTextField.text = self.report.reportname
            
            cell.onChangeHandler = { [weak self, weak cell] in
                self?.report.reportname = $0
                
                let validationMessage = self?.report.validationMessage(for: \.reportname)
                cell?.validationMessage = validationMessage
            }
            cell.validationMessage = self.report.validationMessage(for: \.reportname)
            return cell
            
        // Setup editable `FUITitleFormCell` for Report Location
        case (1, 0):
            let cell = tableView.dequeueReusableCell(withIdentifier: FUITitleFormCell.reuseIdentifier, for: indexPath) as! FUITitleFormCell
            
            cell.placeholderText = "Report location"
            cell.valueTextField.text = self.report.reportlocation
            
            cell.onChangeHandler = { [weak self, weak cell] in
                self?.report.reportlocation = $0
                
                let validationMessage = self?.report.validationMessage(for: \.reportlocation)
                cell?.validationMessage = validationMessage
            }
            cell.validationMessage = self.report.validationMessage(for: \.reportlocation)
            return cell
            
        // Setup editable `FUIDatePickerFormCell` for report Start date
        case (2, 0):
            let cell = tableView.dequeueReusableCell(withIdentifier: FUIDatePickerFormCell.reuseIdentifier, for: indexPath) as! FUIDatePickerFormCell
            cell.keyName = "Start date"
            cell.value = self.report.reportstart!.utc()
            cell.onChangeHandler = { [weak self] in
                self?.report.reportstart = LocalDateTime.from(utc: $0)
            }
            return cell
            
        // Setup editable `FUIDatePickerFormCell` for report End date
        case (2, 1):
            let cell = tableView.dequeueReusableCell(withIdentifier: FUIDatePickerFormCell.reuseIdentifier, for: indexPath) as! FUIDatePickerFormCell
            cell.keyName = "End date"
            cell.value = self.report.reportend!.utc()
            cell.onChangeHandler = { [weak self] in
                self?.report.reportstart = LocalDateTime.from(utc: $0)
            }
            return cell
            
        // Setup editable `FUIListPickerFormCell` for Report status selection
        case (3, 0):
            let cell = tableView.dequeueReusableCell(withIdentifier: FUIListPickerFormCell.reuseIdentifier, for: indexPath) as! FUIListPickerFormCell
            applyDefaultConfiguration(forListPickerFormCell: cell, dataSource: reportStatusPickerDataSource)
            
            cell.keyName = "Report status"
            
            let uuidValues: [String] = {
                guard let id = report.reportstatusid, !id.isEmpty else { return [] }
                return [id]
            }()
            
            cell.uuidValues = uuidValues
            
            let entity = reportStatusPickerDataSource.singleEntity(for: uuidValues)
            cell.valueTextField.text = entity?.description
            cell.validationMessage = self.report.validationMessage(for: \.reportstatusid)
            
            cell.onUuidChangeHandler = { [weak self] in
                let entity = self?.reportStatusPickerDataSource.singleEntity(for: $0)
                self?.report.reportstatusid = entity?.reportstatusid
            }
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
        
        guard let _ = report.reportlocation else {
            return FUIToastMessage.show(message: report.validationMessage(for: \.reportlocation) ?? "invalid reportlocation")
        }
        guard let _ = report.reportstatusid else {
            return FUIToastMessage.show(message: report.validationMessage(for: \.reportstatusid) ?? "invalid status id")
        }
        guard let _ = report.reportstart else {
            return FUIToastMessage.show(message: "Report start is required")
        }
        guard let _ = report.reportend else {
            return FUIToastMessage.show(message: "Report name is required")
        }
        guard let _ = report.reportname else {
            return FUIToastMessage.show(message: report.validationMessage(for: \.reportname) ?? "invalid report name")
        }
        
        do {
            let statusQuery = DataQuery().withKey(ReportStatusType.key(reportstatusid: self.report.reportstatusid!))
            let status = try Single.required(DataHandler.shared.service.fetchReportStatus(matching: statusQuery))
            
            let changeSet = ChangeSet()
            changeSet.createEntity(self.report)
            changeSet.createLink(from: self.report, property: ExpenseReportItemType.reportStatus, to: status)

            try DataHandler.shared.service.applyChanges(changeSet)
        }
        catch {
            print(error)
        }
        
        self.dismiss(animated: true, completion: nil)
    }

}
