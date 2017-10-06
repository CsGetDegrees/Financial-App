//
//  HeaderViewCell.swift
//  Budgetable
//  This is the header view for every page.
//  Created by Tengzhe Li on 21/09/17.
//  Copyright © 2017 Tengzhe Li. All rights reserved.
//

import UIKit
import UserNotifications

class HeaderViewCell: UITableViewCell {
    
    @IBOutlet weak var Name: UILabel!
    
    @IBOutlet weak var CellType: UILabel!
    
    @IBOutlet weak var Time: UILabel!
    
    @IBOutlet weak var Amount: UILabel!
    
    @IBOutlet weak var icon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
