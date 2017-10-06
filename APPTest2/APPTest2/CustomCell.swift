//
//  CustomCell.swift
//  APPTest2
//  A customizable cell that can be stored in the local storage.
//  Created by Tengzhe Li on 4/30/17.
//  Copyright © 2017 Tengzhe Li. All rights reserved.
//

import UIKit
import UserNotifications

class CustomCell: UITableViewCell{
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var IncomeOrExpense: UILabel!
    
    @IBOutlet weak var Description: UILabel!
    @IBOutlet weak var Amount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    

}
