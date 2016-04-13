//
//  AccountTableViewCell.swift
//  MoneySaver
//
//  Created by Alejandro Zamudio Guajardo on 4/13/16.
//
//

import UIKit

class AccountTableViewCell: UITableViewCell {
    
    @IBOutlet weak var accountIcon: UIImageView!
    @IBOutlet weak var accountName: UILabel!
    @IBOutlet weak var accountType: UILabel!
    @IBOutlet weak var accountBalance: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
