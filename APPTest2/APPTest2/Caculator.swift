//
//  Caculator.swift
//  Budgetable
//
//  Created by Tengzhe Li on 22/09/17.
//  Copyright © 2017 Tengzhe Li. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class Caculator:  UIViewController,UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var IncomeExpense: UISegmentedControl!
    @IBOutlet weak var CountShow: UIButton!
    
    @IBOutlet weak var TimePick: UITextField!
    
    @IBOutlet weak var Description: UITextField!
    
    
    let datePicker = UIDatePicker()
    
    
    var numShowOnScreen:Double = 0.0
    var previousNum: Double = 0.0
    var performingMath = false
    
    var operation: Int = 0
    
    var x: String = ""
    var count: Int = 0
    var firstNum: Double = 0.0
    var secondNum: Double = 0.0
    var testNumFirst: Decimal = 0.0
    
    
    @IBOutlet weak var TypeTable: UITableView!
    var list: [String]! = [""]
    var listEx: [String]! = ["Bills","Transport","Clothes","EatingOut","Entertainment","Health","Food","Pet","House","Else"]
    var listIn: [String]! = ["Deposits","Salary","Saving"]
    
    var styleSwitch: Bool = false
    var TypeSwitch: Int = 0
    var listCount: Int = 0
    
    @IBAction func TypeSwitch(_ sender: UISegmentedControl) {
        TypeSwitch =  sender.selectedSegmentIndex
        print(TypeSwitch)
        if(TypeSwitch == 1){
            list = listEx
            self.TypeTable.reloadData()
        }else{
            list = listIn
            self.TypeTable.reloadData()
        }
        
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return list.count;
    }
    
    
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height:CGFloat = CGFloat()
        if (styleSwitch){
            height = 44
        }else{
            height = 0
        }
        return height
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = self.TypeTable.dequeueReusableCell(withIdentifier: "cellHeader", for: indexPath)as! HeaderViewCell
        cell.transform = CGAffineTransform(scaleX: 1, y: -1);
        
        
        cell.Name.text = list[indexPath.row]
        return(cell)
        
        
    }

    //Connect to CustomCell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        print(indexPath[1])
        
        if(Description.text != ""){
            print(2222)
            
            
            let IncomeOrExpense = UserDefaults.standard.object(forKey: "IncomeOrExpense")
            var InOrEx:[Int]
            if let tempInOrEx = IncomeOrExpense as? [Int]{
                InOrEx = tempInOrEx
                InOrEx.append(TypeSwitch)
                
            }else{
                InOrEx = [TypeSwitch]
            }
            UserDefaults.standard.set(InOrEx,forKey: "IncomeOrExpense")
            
            let InputType = UserDefaults.standard.object(forKey: "InputType")
            var InType:[Int]
            if let tempInType = InputType as? [Int]{
                InType = tempInType
                InType.append(indexPath[1])
                
            }else{
                InType = [indexPath[1]]
            }
            UserDefaults.standard.set(InType,forKey: "InputType")
            
            saveAmount()
            saveDate()
            saveNotificationID()
            
            let AddObject = UserDefaults.standard.object(forKey: "Add")
            var add:[String]
            if let tempAdd = AddObject as? [String]{
                add = tempAdd
                add.append(Description.text!)
                
            }else{
                add = [Description.text!]
            }
            UserDefaults.standard.set(add,forKey: "Add")
            
            
            
        }
        // performSegue(withIdentifier: "segue2", sender: self)
      self.dismiss(animated: true, completion: nil)
    }
    
    func saveDate(){
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
    }
    
    func notificatonSender(UniqueID:String){
        let content = UNMutableNotificationContent()
        content.title = "title"
        content.subtitle = "Subtitle"
        content.body = "Body"
  
        let calander = Calendar(identifier: .gregorian)
        let triggerDate = calander.dateComponents([.year,.month,.day,.hour,.minute], from: datePicker.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching:triggerDate, repeats: false)
        let request = UNNotificationRequest(identifier: UniqueID, content: content, trigger:trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
    }
    
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
    
    func saveAmount(){

        let amountObject = UserDefaults.standard.object(forKey: "Amount")
        var amount:[Double]
        if let tempAmount = amountObject as? [Double]{
            amount = tempAmount
            let a = Double(numShowOnScreen)
            print("Is Double \(a)")
            amount.append(Double(numShowOnScreen))
            
        }else{
            amount = [Double(numShowOnScreen)]
        }
        print(amount)
        UserDefaults.standard.set(amount,forKey: "Amount")
    }

    //Still Need to Add Decimal ponint and Delete Function
    @IBAction func Number(_ sender: Any) {
        if performingMath == true {
            
            let  j =  String((sender as AnyObject).tag)
            CountShow.setTitle(j, for: .normal)
            
            print(j)
            numShowOnScreen = Double(j)!
            print(numShowOnScreen)
            performingMath = false
            
        }else{
            
            if CountShow.currentTitle == nil {
                
                x = String((sender as AnyObject).tag)
                
                CountShow.setTitle(x, for: .normal)
                numShowOnScreen = Double(x)!
           
                print("jjj\(numShowOnScreen)")
            }else{
                //If input is "."
                if (sender as AnyObject).tag == 10 {
                    x = CountShow.currentTitle! + "."
                    print("....")
                }else{
                    //Find last char of Screen
                    let z = x.characters.count-1
                    let y = x.index(x.startIndex, offsetBy: z)
                    print(x[y])
                    
                    
                    
                    x =  CountShow.currentTitle! + String((sender as AnyObject).tag)
                    CountShow.setTitle(x, for: .normal)
                }
                print(x)
                numShowOnScreen = Double(x)!
            }
        }
    }
    //Has error during double transation
    @IBAction func Count(_ sender: Any) {
        
        let numTest = Double(CountShow.currentTitle!)
        
        if CountShow.currentTitle != nil && numTest != nil && (sender as AnyObject).tag != 15 && (sender as AnyObject).tag != 17
        {
            previousNum = Double(CountShow.currentTitle!)!
            if (sender as AnyObject).tag == 11{
                CountShow.setTitle("+", for: .normal)
            }
            else if (sender as AnyObject).tag == 12
            {
                CountShow.setTitle("-", for: .normal)
            }else if (sender as AnyObject).tag == 13
            {
                CountShow.setTitle("x", for: .normal)
            }else if (sender as AnyObject).tag == 14
            {
                CountShow.setTitle("/", for: .normal)
            }
            
            operation = (sender as AnyObject).tag
            performingMath = true
            print(operation)
            
        }else if (sender as AnyObject).tag == 15{
            
            if operation == 11
            {
                print("+++++")
                let a =  String(previousNum + numShowOnScreen)
                print(a)
                CountShow.setTitle(a, for: .normal)
            }else if operation == 12
            {
                print("----")
                let a =  String(previousNum-numShowOnScreen)
                print(a)
                CountShow.setTitle(a, for: .normal)
            }else if operation == 13
            {
                print("xxxxx")
                let a =  String(previousNum*numShowOnScreen)
                print(a)
                CountShow.setTitle(a, for: .normal)
            }else if operation == 14
            {
                print("///////")
                let a =  String(previousNum/numShowOnScreen)
                print(a)
                CountShow.setTitle(a, for: .normal)
            }
        } else if (sender as AnyObject).tag == 17{
            
            print("Clear All")
            CountShow.setTitle("", for: .normal)
            previousNum = 0;
            numShowOnScreen = 0;
            operation = 0;
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // UpdateTime()
        createTimePicker()
        list = listIn
        self.TypeTable.transform = CGAffineTransform(scaleX: 1, y: -1);
         TypeTable.isHidden = true;

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Done buttom for TimePicker
    func donePressed(sender:UIBarButtonItem){
        //format
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .short
        dateFormat.timeStyle = .short
        
        
        TimePick.text = dateFormat.string(from: datePicker.date)
        self.view.endEditing(true)
        
        
    }
    
    func createTimePicker(){
        //format for picker
        datePicker.datePickerMode = .dateAndTime
        
        // TimePick.text = ""
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
    
    
    @IBAction func AddType(_ sender: Any) {
//        performSegue(withIdentifier: "segue1", sender: self)
        if(styleSwitch){
            styleSwitch = false;
            self.perform(#selector(HideType), with: nil, afterDelay: 0.3)
            
        }else{
            styleSwitch = true;
           
            TypeTable.isHidden = false;
        }
        //self.TypeTable.reloadData()
        TypeTable.beginUpdates()
        TypeTable.endUpdates()
            }
    
    
    func HideType() {
        TypeTable.isHidden = true;
    }
    

    @IBAction func CancelAdd(_ sender: Any) {
        //performSegue(withIdentifier: "segue2", sender: self)
        self.dismiss(animated: true, completion: nil)
    }
    
}


