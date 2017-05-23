//
//  CustomCell.swift
//  APPTest2
//
//  Created by Tengzhe Li on 4/30/17.
//  Copyright © 2017 Tengzhe Li. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell{
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var name: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    

}
