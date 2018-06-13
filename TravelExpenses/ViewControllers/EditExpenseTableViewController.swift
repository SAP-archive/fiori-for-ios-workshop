//
//  EditExpenseTableViewController.swift
//  TravelExpenseApp
//
//  Created by Stadelman, Stan on 2/23/18.
//  Copyright © 2018 Stadelman, Stan. All rights reserved.
//

import SAPFiori
import SAPOData
import UIKit

class EditExpenseTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(FUIKeyValueFormCell.self, forHeaderFooterViewReuseIdentifier: FUIKeyValueFormCell.reuseIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in _: UITableView) -> Int {
        return 2
    }

    override func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 7
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FUIKeyValueFormCell.reuseIdentifier, for: indexPath) as! FUIKeyValueFormCell
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell.keyName = "Expense Type"
                cell.value = "Airfare"
            case 1:
                cell.keyName = "Vendor"
                cell.value = "Delta Airlines"
            case 2:
                cell.keyName = "Transaction Date"
                cell.value = "09/05/2017"
            case 3:
                cell.keyName = "Location"
                cell.value = "Palo Alto, CA"
            case 4:
                cell.keyName = "Amount"
                cell.value = "126.40"
            case 5:
                cell.keyName = "Currency"
                cell.value = "USD"
            default:
                cell.keyName = "Payment"
                cell.value = "Company paid"
            }
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: FUIAttachmentsFormCell.reuseIdentifier, for: indexPath) as! FUIAttachmentsFormCell

            //            cell.attachmentsController.delegate = self
            //            cell.attachmentsController.dataSource = self
            return cell
        }

        // Configure the cell...

        return cell
    }

    var attachmentURLs: [URL] = [URL]()
}

/*
 extension EditExpenseTableViewController: FUIAttachmentsViewControllerDataSource, FUIAttachmentsViewControllerDelegate {

 // MARK: FUIAttachmentsViewControllerDataSource methods
 func attachmentsViewController(_ attachmentsViewController: FUIAttachmentsViewController, iconForAttachmentAtIndex index: Int) -> (image: UIImage, contentMode: UIViewContentMode)? {
 let urlString = self.attachmentURLs[index].absoluteString
 let image = FUIIconLibrary.docType.image.withRenderingMode(.alwaysTemplate)
 return (image, .scaleAspectFill)
 }

 func numberOfAttachments(in attachmentsViewController: FUIAttachmentsViewController) -> Int {
 return attachmentURLs.count
 }

 func attachmentsViewController(_ attachmentsViewController: FUIAttachmentsViewController, urlForAttachmentAtIndex index: Int) -> URL? {
 return attachmentURLs[index]
 }

 // MARK:  FUIAttachmentsViewControllerDelegateMethods
 func attachmentsViewController(_ attachmentsViewController: FUIAttachmentsViewController, couldNotPresentAttachmentAtIndex index: Int) {

 }

 func attachmentsViewController(_ attachmentsViewController: FUIAttachmentsViewController, didPressDeleteAtIndex index: Int) {
 self.attachmentURLs.remove(at: index)
 self.tableView.reloadSections(IndexSet(integer:attachmentSection), with: .automatic)
 }

 //MARK: FUIAddPhotoAttachmentActionDelegate
 func addPhotoAttachmentAction(_ action: FUIAddPhotoAttachmentAction, didSelectPhotoAt url: URL) {
 self.addAttachmentURL(url)
 }

 //MARK: FUITakePhotoAttachmentActionDelegate

 func takePhotoAttachmentAction(_ action: FUITakePhotoAttachmentAction, didTakePhotoAt url: URL) {
 self.addAttachmentURL(url)
 }

 func addAttachmentURL(_ url: URL) {
 self.attachmentURLs.append(url)
 DispatchQueue.main.async {
 self.tableView.reloadSections(IndexSet(integer:self.attachmentSection), with: .automatic)
 self.tableView.scrollToRow(at: IndexPath(row: 0, section: self.attachmentSection) , at: .middle, animated: true)
 }
 }
 }
 */
