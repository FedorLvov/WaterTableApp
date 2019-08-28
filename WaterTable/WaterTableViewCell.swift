//
//  WaterTableViewCell.swift
//  WaterTable
//
//  Created by Fedor Lvov on 28/08/2019.
//  Copyright © 2019 Fedor Lvov. All rights reserved.
//

import UIKit

class WaterTableViewCell: UITableViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLable: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
