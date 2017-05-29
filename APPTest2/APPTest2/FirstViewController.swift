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
    
    @IBOutlet weak var amountInput: UITextField!
    
    
    
    @IBOutlet weak var Description: UITextView!
    
    let datePicker = UIDatePicker()
    
    
    @IBOutlet weak var typeOpen: UIButton!
    
    @IBOutlet weak var type0: UIButton!
    
    @IBOutlet weak var type1: UIButton!
    
    @IBOutlet weak var type2: UIButton!
    
    @IBOutlet weak var type3: UIButton!
    
    @IBOutlet weak var type4: UIButton!
    
    @IBOutlet weak var type5: UIButton!
    
    @IBOutlet weak var type6: UIButton!
    
    @IBOutlet weak var type7: UIButton!
    @IBOutlet weak var type8: UIButton!
    
    @IBOutlet weak var IncomeButtom: UIButton!
    
    @IBOutlet weak var ExpenseButtom: UIButton!
    
    
    
    
    var trueOrFalse = false
    
    func hiddenButton () {
        type0.isHidden = true
        type1.isHidden = true
        type2.isHidden = true
        type3.isHidden = true
        type4.isHidden = true
        type5.isHidden = true
        type6.isHidden = true
        type7.isHidden = true
        type8.isHidden = true
        
        
    }
 
    @IBAction func DoubleCheck(_ sender: Any) {
        let check = Double(amountInput.text!)
        
        if(check != nil){
            print("good")
            IncomeButtom.isUserInteractionEnabled = true
            ExpenseButtom.isUserInteractionEnabled = true
            
        }else{
            
            IncomeButtom.isUserInteractionEnabled = false
            ExpenseButtom.isUserInteractionEnabled = false
            print("bad")
            
        }

    }
    
//    @IBAction func Checkcheck(_ sender: Any) {
//        
//        let check = Double(amountInput.text!)
//        
//        print("hahah")
//        
//        if(check != nil){
//            print("good")
//            IncomeButtom.isUserInteractionEnabled = true
//            ExpenseButtom.isUserInteractionEnabled = true
//            
//        }else{
//            
//            IncomeButtom.isUserInteractionEnabled = false
//            ExpenseButtom.isUserInteractionEnabled = false
//            print("bad")
//            
//        }
//
//    }
    
    
    @IBAction func styleList(_ sender: Any) {
        if trueOrFalse {
            type0.isHidden = true
            type1.isHidden = true
            type2.isHidden = true
            type3.isHidden = true
            type4.isHidden = true
            type5.isHidden = true
            type6.isHidden = true
            type7.isHidden = true
            type8.isHidden = true
            
            
            
            trueOrFalse = false
        }else{
            type0.isHidden = false
            type1.isHidden = false
            type2.isHidden = false
            type3.isHidden = false
            type4.isHidden = false
            type5.isHidden = false
            type6.isHidden = false
            type7.isHidden = false
            type8.isHidden = false
            
            trueOrFalse = true
        }
        //type1.frame.size.height = 0
    }
    
    var typeSelect:Int = 8
    @IBAction func typeSelection(_ sender: Any) {
        //print((sender as AnyObject).tag)
        typeSelect = (sender as AnyObject).tag
        print("Select Type\(typeSelect)")
        typeOpen.setTitle("Select Type\(typeSelect)", for: .normal)
        hiddenButton ()
        trueOrFalse = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // UpdateTime()
        createTimePicker()
        //        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        hiddenButton ()
        
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
    func saveAmount(){
        //        if let check = Double(amountInput.text!){
        //            print("good")
        //        }else{
        //            print("bad")
        //        }
        let amountObject = UserDefaults.standard.object(forKey: "Amount")
        var amount:[Double]
        if let tempAmount = amountObject as? [Double]{
            amount = tempAmount
            amount.append(Double(amountInput.text!)!)
            
        }else{
            amount = [Double(amountInput.text!)!]
        }
        print(amount)
        UserDefaults.standard.set(amount,forKey: "Amount")
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
    
    //
    //Save & Make a Notification
    func saveNotificationID(){
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
       
        }else{
            UUID = [UniqueID]
           
        }
        print("UniqueID\(UniqueID)")
        UserDefaults.standard.set(UUID,forKey: "UniqueID")
        
        
        notificatonSender(UniqueID: UniqueID)
        
    }
    func savedescription(){
        let descriptionObject = UserDefaults.standard.object(forKey: "Description")
        var description:[String]
        if let tempDescription = descriptionObject as? [String]{
            description = tempDescription
            description.append(Description.text!)
            
        }else{
            description = [Description.text!]
        }
        print(description)
        UserDefaults.standard.set(description,forKey: "Description")
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
            
            //check Double
            saveAmount()
            
            //Add Type of Amount
            let typeObject = UserDefaults.standard.object(forKey: "TypeOfAmount")
            var AmountType:[Int]
            
            if let tempType = typeObject as? [Int]{
               AmountType = tempType
                AmountType.append(typeSelect)
    
            }else{
                
                AmountType = [typeSelect]
            }
            UserDefaults.standard.set(AmountType,forKey: "TypeOfAmount")

            
            
            savedescription()
            saveNotificationID()
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
            
            //check Double
           
 saveAmount()
            
            //Add Type of Amount
            let typeObject = UserDefaults.standard.object(forKey: "TypeOfAmount")
            var AmountType:[Int]
            
            if let tempType = typeObject as? [Int]{
                AmountType = tempType
                AmountType.append(Int(typeSelect))
                
            }else{
                
                AmountType = [Int(typeSelect)]
            }
            UserDefaults.standard.set(AmountType,forKey: "TypeOfAmount")

            savedescription()
            //The UniqueID for Notification
            saveNotificationID()
            // introduction.append("Nope")
            InputTextField.text = ""
            
        }
        
    }
    
    
    
}
