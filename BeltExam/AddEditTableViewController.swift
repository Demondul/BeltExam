//
//  AddEditTableViewController.swift
//  BeltExam
//
//  Created by El Capitan on 7/20/18.
//  Copyright © 2018 Carlo Del Mundo. All rights reserved.
//

import UIKit

class AddEditTableViewController: UITableViewController {

    @IBOutlet weak var textField: UITextField!
    
    var thisBeast: Beast?
    var EditMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if EditMode {
            textField.text = thisBeast?.beast!
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func CancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func DoneButtonPressed(_ sender: UIBarButtonItem) {
        if EditMode{
            let BeastData = TheBeast(leBeast: thisBeast!)
            BeastData.type = textField.text!
            BeastData.Save()
        }
        else {
            let BeastData = TheBeast()
            BeastData.type = textField.text!
            BeastData.beasted = "False"
            BeastData.Add()
        }
        dismiss(animated: true, completion: nil)
    }
    
}
