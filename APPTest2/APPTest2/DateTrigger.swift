//
//  DateTrigger.swift
//  Budgetable
//
//  Created by Tengzhe Li on 30/09/17.
//  Copyright © 2017 Tengzhe Li. All rights reserved.
//

import Foundation
import UIKit

class DateTrigger: UIViewController{

    
    
    @IBAction func Today(_ sender: Any) {
        let tag: Int = (sender as AnyObject).tag
        
       let timeRangeSwitch = 0
        _ = UserDefaults.standard.object(forKey: "TimeSwitch")
        var TSwitch:Int
        TSwitch = timeRangeSwitch
        UserDefaults.standard.set(TSwitch,forKey: "TimeSwitch")
        
        //Saveing Time tag to local storage for switching time range for table view
        _ = UserDefaults.standard.object(forKey: "TimeRangeTag")
        var TTag:Int
        TTag = tag
        UserDefaults.standard.set(TTag,forKey: "TimeRangeTag")
        print(TTag)
       // TotalView().viewDidAppear(true)
    //self.performSegue(withIdentifier: "segue4", sender: self)
        //self.navigationController?.popViewController(animated: true)
       self.dismiss(animated: true, completion: nil)
        //TotalView().viewDidAppear(true)
    }




}
