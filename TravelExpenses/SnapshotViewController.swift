//
// SnapshotViewController.swift
// TravelExpenses
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 09/06/18
//

import Foundation
import UIKit

// This ViewController is used as a snapshot screen when the app is put to the background
class SnapshotViewController: UIViewController {
    private var imageView: UIImageView!

    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white

        let sapLogo = UIImage(named: "SAPLogo.png")!
        self.imageView = UIImageView(image: sapLogo)
        self.imageView.center = self.view.center

        self.view.addSubview(imageView)
    }
}
