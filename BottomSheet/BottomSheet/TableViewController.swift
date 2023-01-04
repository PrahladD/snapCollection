//
//  TableViewController.swift
//  BottomSheet
//
//  Created by Prahlad Dhungana on 2022-06-14.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    @IBOutlet weak var tableView: UITableView!
    
    var names: [String] = [
        "Olivia",
        "Emma",
        "Charlotte",
        "Amelia",
        "Ava",
        "Sophia",
        "Isabella",
        "Mia",
        "Tina",
        "Aasha",
        "Karisma"
    ]
    
    weak var delegate: ModalViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.bounces = true
        
        tableView.alwaysBounceVertical = true
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "TableViewCell", bundle: .main)
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.register(nib, forCellReuseIdentifier: "TableViewCell")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.invalidateIntrinsicContentSize()
        delegate?.openModel(height: tableView.contentSize.height)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        print("hello")
    }

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TableViewCell.self)) as? TableViewCell
        cell?.name.text = names[indexPath.row]
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
}

extension TableViewController: ModalContainer {
    var headerTitle: String {
        return "Details"
    }
}
