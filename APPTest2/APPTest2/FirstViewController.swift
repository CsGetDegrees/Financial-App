//  FirstViewController.swift
//  APPTest2
//
//  Created by Tengzhe Li on 4/25/17.
//  Copyright © 2017 Tengzhe Li. All rights reserved.
//


import UIKit
import UserNotifications

class FirstViewController: UIViewController{
   
    @IBOutlet weak var InputTextField: UITextField!
   
    @IBOutlet weak var CurrentTime: UILabel!
    
    @IBOutlet weak var TimePick: UITextField!

   
    let datePicker = UIDatePicker()
    

    
    
    @IBAction func jump(_ sender: Any) {
         performSegue(withIdentifier: "segue1", sender: self)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    
        // UpdateTime()
        createTimePicker()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    override func viewDidAppear(_ animated: Bool) {
   
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
   
    func notificatonSender(UniqueID:String){
        let content = UNMutableNotificationContent()
        content.title = "title"
        content.subtitle = "Subtitle"
        content.body = "Body"
        //content.badge = 1
        
//        let currentDate = Date()
//        let interval = (datePicker.date).timeIntervalSince(currentDate)
        
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)
        let calander = Calendar(identifier: .gregorian)
        let triggerDate = calander.dateComponents([.year,.month,.day,.hour,.minute], from: datePicker.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching:triggerDate, repeats: false)
        let request = UNNotificationRequest(identifier: UniqueID, content: content, trigger:trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
    }

    
    @IBAction func AddText(_ sender: AnyObject) {
        if(InputTextField.text != ""){
            print("Print 111111")
            let IncomeOrExpense = UserDefaults.standard.object(forKey: "incomeOrExpense")
            var expense:[Int]
            if let tempExpense = IncomeOrExpense as? [Int]{
                expense = tempExpense
                expense.append(1)
                
            }else{
                expense = [1]
            }
            UserDefaults.standard.set(expense,forKey: "incomeOrExpense")
            
            
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
            
            //The UniqueID for Notification
            let currentDate = Date()
            let TempID = NSUUID().uuidString
            var UniqueID:String;
            if currentDate < (datePicker.date){
                UniqueID = TempID
                print("UniqueID\(UniqueID)")
            }else{
                UniqueID = "0"
            }
            
            let UUIDObject = UserDefaults.standard.object(forKey: "UniqueID")
            var UUID:[String]
            if let tempUUID = UUIDObject as? [String]{
                UUID = tempUUID
                UUID.append(UniqueID)
                print("UniqueID\(UniqueID)")
            }else{
                UUID = [UniqueID]
                print("UniqueID\(UniqueID)")
            }
            print("UniqueID\(UniqueID)")
            UserDefaults.standard.set(UUID,forKey: "UniqueID")
            
            notificatonSender(UniqueID: UniqueID)
           // introduction.append("Nope")
            InputTextField.text = ""
           
        }
    }
    
    @IBAction func IncomeSave(_ sender: Any) {
        if(InputTextField.text != ""){
           print(2222)
            let IncomeOrExpense = UserDefaults.standard.object(forKey: "incomeOrExpense")
            var income:[Int]
            if let tempIncome = IncomeOrExpense as? [Int]{
                income = tempIncome
                income.append(2)
                
            }else{
                income = [2]
            }
            UserDefaults.standard.set(income,forKey: "incomeOrExpense")
            
            
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
            
            //The UniqueID for Notification
            let currentDate = Date()
           let TempID = NSUUID().uuidString
            var UniqueID:String;
            if currentDate < (datePicker.date){
                 UniqueID = TempID
                print("UniqueID\(UniqueID)")
            }else{
                 UniqueID = "0"
            }
            
            let UUIDObject = UserDefaults.standard.object(forKey: "UniqueID")
            var UUID:[String]
            if let tempUUID = UUIDObject as? [String]{
                UUID = tempUUID
                UUID.append(UniqueID)
                print("UniqueID\(UniqueID)")
            }else{
                UUID = [UniqueID]
                print("UniqueID\(UniqueID)")
            }
            print("UniqueID\(UniqueID)")
            UserDefaults.standard.set(UUID,forKey: "UniqueID")
            
            notificatonSender(UniqueID: UniqueID)
            // introduction.append("Nope")
            InputTextField.text = ""
            
        }
        
           }

    

}
