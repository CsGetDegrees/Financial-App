// Unused Class.




//  TableCell.swift
//  APPTest2
//
//  Created by Tengzhe Li on 4/26/17.
//  Copyright © 2017 Tengzhe Li. All rights reserved.
//

import UIKit
import UserNotifications
//Useless Class
class TableCell: UIViewController{

    @IBOutlet weak var TitleLabel: UILabel!

    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var Information: UITextField!
    
//    func notificatonSender(){
//        let content = UNMutableNotificationContent()
//        content.title = "title"
//        content.subtitle = "Subtitle"
//        content.body = "Body"
//        //content.badge = 1
//        
//        let currentDate = Date()
//     
//        let interval = (dateInput[myIndex]).timeIntervalSince(currentDate)
//        print(interval)
//        if(interval > 30){
//            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)
//            
//            let request = UNNotificationRequest(identifier: "timeDone", content: content, trigger:trigger)
//            
//            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
//        }
//    }
   
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
