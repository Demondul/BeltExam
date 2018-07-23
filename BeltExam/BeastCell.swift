//
//  BeastTableViewCell.swift
//  BeltExam
//
//  Created by El Capitan on 7/20/18.
//  Copyright © 2018 Carlo Del Mundo. All rights reserved.
//

import UIKit

protocol ThisCellDelegate: class {
    func BeastButton(from sender: BeastCell, indexPath: IndexPath)
}

class BeastCell: UITableViewCell {
    @IBOutlet weak var BeastLabel: UILabel!
    @IBOutlet weak var BeastButton: UIButton!
    
    var delegate: ThisCellDelegate!
    var indexPath: IndexPath!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func BeastButtonPressed(_ sender: UIButton) {
        delegate.BeastButton(from: self, indexPath: self.indexPath)
    }
}
