//
//  TransactionTableViewCell.swift
//  MoneySaver
//
//  Created by Alejandro Zamudio Guajardo on 4/23/16.
//
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    @IBOutlet weak var transactionPayee: UILabel!
    @IBOutlet weak var relatedAccountName: UILabel!
    @IBOutlet weak var transactionAmount: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
