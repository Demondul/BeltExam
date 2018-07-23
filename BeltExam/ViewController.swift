//
//  ViewController.swift
//  BeltExam
//
//  Created by El Capitan on 7/20/18.
//  Copyright © 2018 Carlo Del Mundo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let theBeast:TheBeast = TheBeast()
    var tableData:[Beast] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableData = theBeast.FetchAll()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 95
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableData = theBeast.FetchAll()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        tableView.rowHeight = 95
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let thisBeast = sender as? Beast {
            let navigation = segue.destination as! UINavigationController
            let destination = navigation.topViewController as! AddEditTableViewController
            destination.thisBeast = thisBeast
            destination.EditMode = true
        }
    }

    @IBAction func AddEditButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "AddEditSegue", sender: self)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BeastCell", for: indexPath) as! BeastCell
        
        cell.BeastLabel.text = tableData[indexPath.row].beast
        cell.delegate = self
        cell.indexPath = indexPath
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let thisBeast = tableData[indexPath.row]
        performSegue(withIdentifier: "AddEditSegue", sender: thisBeast)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
            action, view, completionHandler in
            let deleteBeast = TheBeast(leBeast: self.tableData[indexPath.row])
            self.tableData = deleteBeast.Delete(isBeasted: false)

            tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        let swipeConfig = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeConfig
    }
}

extension ViewController: ThisCellDelegate {
    func BeastButton(from sender: BeastCell, indexPath: IndexPath) {
        let Beasted = TheBeast(leBeast:tableData[indexPath.row])
        
        Beasted.beasted = "True"
        Beasted.Save()
        
        self.tableData = self.theBeast.FetchAll()
        tableView.reloadData()
    }
    
    
}

