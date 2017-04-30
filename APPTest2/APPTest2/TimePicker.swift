//
//  TimePicker.swift
//  APPTest2
//
//  Created by Tengzhe Li on 4/29/17.
//  Copyright © 2017 Tengzhe Li. All rights reserved.
//

import UIKit

class TimePicker: UIViewController{

    @IBOutlet weak var CurrentTime: UILabel!
   
    @IBOutlet weak var TimePick: UITextField!
    
   let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(TimePicker.UpdateTime), userInfo: nil, repeats: true)
       // UpdateTime()
        createTimePicker()
            }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
   func UpdateTime(){
        CurrentTime.text = DateFormatter.localizedString(from: NSDate() as Date , dateStyle: DateFormatter.Style.none, timeStyle: DateFormatter.Style.full)
    }
    
    func createTimePicker(){
        //format for picker
        datePicker.datePickerMode = .dateAndTime
        
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //bar button item
        let doneButton = UIBarButtonItem(barButtonSystemItem:.done, target: nil, action: #selector(donePressed))
        
        toolbar.setItems([doneButton], animated: false)
        
        TimePick.inputAccessoryView = toolbar
        
        // assigning time pick to text field
        TimePick.inputView = datePicker
        
    }
    func donePressed(){
        //format
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .short
        dateFormat.timeStyle = .short
        
        
    TimePick.text = dateFormat.string(from: datePicker.date)
        self.view.endEditing(true)
        print("\(datePicker.date)")
    }
}
