//
//  TableCell.swift
//  APPTest2
//
//  Created by Tengzhe Li on 4/26/17.
//  Copyright © 2017 Tengzhe Li. All rights reserved.
//

import UIKit
import UserNotifications

class TableCell: UIViewController{

    @IBOutlet weak var TitleLabel: UILabel!

    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var Information: UITextField!
    

   
    override func viewDidLoad() {
    super.viewDidLoad()
        TitleLabel.text = list[myIndex]
        
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .short
        dateFormat.timeStyle = .short
        Information.text = dateFormat.string(from: dateInput[myIndex])
       // ImageView.image = UIImage(named: list[myIndex] + ".jpg")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
