//
//  ReportsPickerDataSource.swift
//  TravelExpenses
//
//  Created by Stadelman, Stan on 6/11/18.
//  Copyright © 2018 SAP SE or an SAP affiliate company.  All rights reserved.
//

import UIKit
import SAPFiori

// MARK: - List picker data source implementation for Expense Report

class ReportsPickerDataSource: BaseEntityTypePickerDataSource<ExpenseReportItemType> {
    
    override func listPickerTableView(_ tableView: UITableView, cellForRowAt index: Int, isFiltered: Bool) -> UITableViewCell {
        let cell = super.listPickerTableView(tableView, cellForRowAt: index, isFiltered: false) as! FUIObjectTableViewCell
        let entity = self.entity(at: index)
        cell.subheadlineText = entity.reportname
        return cell
    }
}

// MARK: - List picker data source implementation for Currency

class CurrencyPickerDataSource: BaseEntityTypePickerDataSource<CurrencyType> {
    
    override func listPickerTableView(_ tableView: UITableView, cellForRowAt index: Int, isFiltered: Bool) -> UITableViewCell {
        let cell = super.listPickerTableView(tableView, cellForRowAt: index, isFiltered: false) as! FUIObjectTableViewCell
        let entity = self.entity(at: index)
        cell.subheadlineText = entity.currencyid
        return cell
    }
}

// MARK: - List picker data source implementation for Payment Type

class PaymentTypePickerDataSource: BaseEntityTypePickerDataSource<PaymentType> {
    
    override func listPickerTableView(_ tableView: UITableView, cellForRowAt index: Int, isFiltered: Bool) -> UITableViewCell {
        let cell = super.listPickerTableView(tableView, cellForRowAt: index, isFiltered: false) as! FUIObjectTableViewCell
        let entity = self.entity(at: index)
        cell.subheadlineText = entity.paymenttypeid
        return cell
    }
}

// MARK: - List picker data source implementation for Expense Type

class ExpenseTypePickerDataSource: BaseEntityTypePickerDataSource<ExpenseType> {
    
    override func listPickerTableView(_ tableView: UITableView, cellForRowAt index: Int, isFiltered: Bool) -> UITableViewCell {
        let cell = super.listPickerTableView(tableView, cellForRowAt: index, isFiltered: false) as! FUIObjectTableViewCell
        let entity = self.entity(at: index)
        cell.subheadlineText = entity.description
        return cell
    }
}

// MARK: - List picker data source implementation for Report Status

class ReportStatusPickerDataSource: BaseEntityTypePickerDataSource<ReportStatusType> {
    
    override func listPickerTableView(_ tableView: UITableView, cellForRowAt index: Int, isFiltered: Bool) -> UITableViewCell {
        let cell = super.listPickerTableView(tableView, cellForRowAt: index, isFiltered: false) as! FUIObjectTableViewCell
        let entity = self.entity(at: index)
        cell.subheadlineText = entity.description
        return cell
    }
}

