//
//  StoreHomepageViewController.swift
//  Store
//
//  Created by Rio Rizky Rainey Ferbiansyah on 21/12/22.
//

import UIKit
import UIKitExtension

class StoreHomepageViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(StoreHomepageHeaderCell.name)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
