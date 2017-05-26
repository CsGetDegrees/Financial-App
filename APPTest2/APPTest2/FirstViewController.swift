//  FirstViewController.swift
//  APPTest2
//
//  Created by Tengzhe Li on 4/25/17.
//  Copyright © 2017 Tengzhe Li. All rights reserved.
//


import UIKit

class FirstViewController: UIViewController{
   
    @IBOutlet weak var InputTextField: UITextField!
   
    @IBOutlet weak var CurrentTime: UILabel!
    
    @IBOutlet weak var TimePick: UITextField!

   
    let datePicker = UIDatePicker()
    
    public func getstuff(){
        let plusObject = UserDefaults.standard.object(forKey: "time")
       // var plus:[String]
        print(plusObject ?? 0)

       
    }
    
    @IBAction func jump(_ sender: Any) {
         performSegue(withIdentifier: "segue1", sender: self)
    }
    
    //
    public func addstuff(a:String){
        let timeObject = UserDefaults.standard.object(forKey: "time")
        var Time:[String]
        
        if let tempTime = timeObject as? [String]{
            Time = tempTime
            Time.append(a)
            // plus = list
        }
        UserDefaults.standard.set(time,forKey: "time")
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(FirstViewController.UpdateTime), userInfo: nil, repeats: true)
        // UpdateTime()
        createTimePicker()
    }
    
    override func viewDidAppear(_ animated: Bool) {
   
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
    
    //Done buttom for TimePicker
    func donePressed(){
        //format
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .short
        dateFormat.timeStyle = .short
        
        
        TimePick.text = dateFormat.string(from: datePicker.date)
        self.view.endEditing(true)
        
        
    }

    
    @IBAction func AddText(_ sender: AnyObject) {
        if(InputTextField.text != ""){
            
            let plusObject = UserDefaults.standard.object(forKey: "plus")
            var plus:[String]
            if let tempPlus = plusObject as? [String]{
                plus = tempPlus
                plus.append(InputTextField.text!)
               
            }else{
                plus = [InputTextField.text!]
            }
       UserDefaults.standard.set(plus,forKey: "plus")
       
            //Save Date To Local Storage
            let timeObject = UserDefaults.standard.object(forKey: "time")
            var Time:[Date]
            
            if let tempTime = timeObject as? [Date]{
                Time = tempTime
                Time.append(datePicker.date)
                // plus = list
            }else{
                print("\(datePicker.date)")
                Time = [datePicker.date]
            }
            UserDefaults.standard.set(Time,forKey: "time")
     
           // introduction.append("Nope")
            InputTextField.text = ""
           
        }
    }
    

    

}
