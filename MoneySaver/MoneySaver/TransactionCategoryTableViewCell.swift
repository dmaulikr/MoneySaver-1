//
//  TransactionCategoryTableViewCell.swift
//  MoneySaver
//
//  Created by Alejandro Zamudio Guajardo on 4/24/16.
//
//

import UIKit

class TransactionCategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var transactionCategoryName: UILabel!
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
