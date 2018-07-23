//
//  BeastedViewController.swift
//  BeltExam
//
//  Created by El Capitan on 7/20/18.
//  Copyright © 2018 Carlo Del Mundo. All rights reserved.
//

import UIKit

class BeastedViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var theBeast: TheBeast?
    var tableData:[Beast] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        theBeast = TheBeast()
        tableData = (theBeast?.FetchBeasted())!
        print(tableData.count)
        tableView.delegate = self
        tableView.dataSource = self
        theBeast = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension BeastedViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BeastedCell", for: indexPath) as! BeastedCell
        
        let formatter = DateFormatter()
        formatter.dateFormat = "E MMMM d"
        if tableData.count > 0 {
            
//            theBeast = TheBeast(leBeast: tableData[indexPath.row])
//            cell.BeastLabel.text = theBeast?.type
//            cell.DateLabel.text = theBeast?.DateInString
            
            cell.BeastLabel.text = tableData[indexPath.row].beast
            cell.DateLabel.text = formatter.string(from: tableData[indexPath.row].date_created!)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
            action, view, completionHandler in
            let deleteBeasted = TheBeast(leBeast: self.tableData[indexPath.row])
            self.tableData = deleteBeasted.Delete(isBeasted: true)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        let swipeConfig = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeConfig
    }
}
