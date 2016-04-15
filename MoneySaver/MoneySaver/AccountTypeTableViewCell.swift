//
//  AccountTypeTableViewCell.swift
//  MoneySaver
//
//  Created by Alejandro Zamudio Guajardo on 4/14/16.
//
//

import UIKit

class AccountTypeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var accountTypeIcon: UIImageView!
    @IBOutlet weak var accountTypeName: UILabel!
    @IBOutlet weak var checkmark: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
