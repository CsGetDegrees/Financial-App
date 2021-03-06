//  Caculator.swift

//  Budgetable

// This class contains a set of simple calculator functions (+,-,*,/). It also contains a data time picker and a input arer.

//  Created by Tengzhe Li on 22/09/17.

//  Copyright © 2017 Tengzhe Li. All rights reserved.

//



import Foundation

import UIKit

import UserNotifications



class Caculator:  UIViewController,UITableViewDelegate, UITableViewDataSource{
    
    
    // array of section cell
    var SavingCell: [sectionCell] = []
    // income that'll be stored in the expense history.
    @IBOutlet weak var IncomeExpense: UISegmentedControl!
    // the number that'll be showed on the screen.
    @IBOutlet weak var CountShow: UIButton!
    
    
    
    @IBOutlet weak var TimePick: UITextField!
    
    
    // description of the transaction
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
    
    
    
    
    // type can be either income/ expense
    @IBOutlet weak var TypeTable: UITableView!
    
    var list: [String]! = [""]
    
    // a list of expense types
    var listEx: [String]! = ["Bills","Transport","Clothes","EatingOut","Entertainment","Health","Food","Pet","House","Else"]
    // imcome types array
    var listIn: [String]! = ["Deposits","Salary","Saving"]
    
    
    
    var styleSwitch: Bool = false
    
    var TypeSwitch: Int = 0
    
    var listCount: Int = 0
    
    
    // button onclick to switch type between income and expense.
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
        var text = list[indexPath.row]
        print(list[indexPath.row])
        //cell.Image = imageList[indexPath.row]
        cell.icon.addSubview(UIImageView(image: resizeImage(image: UIImage(named: text)!,newWidth: 35)))
        
        return(cell)

        
    }
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage? {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }

    
    
    //Connect to CustomCell
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        print(indexPath[1])
        
        //same structure some information just does not showed
        
        if(true){
            
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
            
            
//            if(Description.text==nil || Description.text==""){
//                Description.text = "No Description"
//            }
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
    
    
   // save the date user picked
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
    
    
   // notification
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
        
        
        
        UniqueID = TempID
        
        print("UniqueID\(UniqueID)")
        
        
        
        
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
        
        if currentDate < (datePicker.date){
            notificatonSender(UniqueID: UniqueID)
            
        }
        
        
    }
    
    
    // save the expense value into the local memory.
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
                print("numShowOnScreen\(numShowOnScreen)")
                
            }else{
                
                //If input is "."
                
                
                
                if (sender as AnyObject).tag == 10 {
                    
                    var hasDot = false;
                    
                    var prevWord = CountShow.currentTitle
                    
                    for index in (prevWord?.characters.indices)! {
                        
                        if prevWord?[index] == "."{
                            
                            hasDot=true;
                            
                        }
                        
                    }
                    
                    if(!hasDot){
                        
                        
                        
                        x = CountShow.currentTitle! + "."
                        
                        CountShow.setTitle(x, for: .normal)
                        
                    }else{
                        
                        
                        
                    }
                    
                }else{
                    
                    //Find last char of Screen
                    
                    
                    
                    x =  CountShow.currentTitle! + String((sender as AnyObject).tag)
                    
                    //var a = (Double(x)!).truncate(places: 0)
                    
                    var hasDot = false
                    
                    var cc=0
                    
                    var result = ""
                    
                    for index in x.characters.indices {
                        
                        if(!hasDot){
                            
                            result+="\(x[index])";
                            
                            if x[index] == "."{
                                
                                hasDot=true;
                                
                            }
                            
                        }else{
                            
                            cc+=1;
                            
                            if(cc<3){
                                
                                result+="\(x[index])";
                                
                            }
                            
                            
                            
                        }
                        
                    }
                    
                    CountShow.setTitle( result, for: .normal)
                    
                }
                
                print(x)
                
                
                
                
                
                // if  Int(x) != nil{
                
                //  numShowOnScreen = Int(x)!
                
                //  }else{
                
                // round(Double(x)!)
                
                numShowOnScreen = Double(x)!
                
                //  }
                
            }
            
        }
        
    }
    
    
    
    
    // react to onclick events for operational buttons
    @IBAction func Count(_ sender: Any) {
        
        
        
        
        
        if CountShow.currentTitle != nil  && (sender as AnyObject).tag != 15 && (sender as AnyObject).tag != 17
            
        {
            
            if(CountShow.currentTitle != "+" && CountShow.currentTitle != "-"  && CountShow.currentTitle != "x"  && CountShow.currentTitle != "/" ){
                
                previousNum = Double(CountShow.currentTitle!)!
                
            }
            
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
                
                let x =  String(previousNum + numShowOnScreen)
                 previousNum = 0 ;
                var hasDot = false
                
                var cc=0
                
                var result = ""
                
                for index in x.characters.indices {
                    
                    if(!hasDot){
                        
                        result+="\(x[index])";
                        
                        if x[index] == "."{
                            
                            hasDot=true;
                            
                        }
                        
                    }else{
                        
                        cc+=1;
                        
                        if(cc<3){
                            
                            result+="\(x[index])";
                            
                        }
                        
                        
                        
                    }
                    
                }
                
                CountShow.setTitle( result, for: .normal)
                
                
                
            }else if operation == 12
                
            {
                
                let x =  String(previousNum - numShowOnScreen)
                 previousNum = 0 ;
                var hasDot = false
                
                var cc=0
                
                var result = ""
                
                for index in x.characters.indices {
                    
                    if(!hasDot){
                        
                        result+="\(x[index])";
                        
                        if x[index] == "."{
                            
                            hasDot=true;
                            
                        }
                        
                    }else{
                        
                        cc+=1;
                        
                        if(cc<3){
                            
                            result+="\(x[index])";
                            
                        }
                        
                        
                        
                    }
                    
                }
                
                CountShow.setTitle( result, for: .normal)
                
                
                
            }else if operation == 13
                
            {
                
                let x =  String(previousNum * numShowOnScreen)
                 previousNum = 0 ;
                var hasDot = false
                
                var cc=0
                
                var result = ""
                
                for index in x.characters.indices {
                    
                    if(!hasDot){
                        
                        result+="\(x[index])";
                        
                        if x[index] == "."{
                            
                            hasDot=true;
                            
                        }
                        
                    }else{
                        
                        cc+=1;
                        
                        if(cc<3){
                            
                            result+="\(x[index])";
                            
                        }
                        
                        
                        
                    }
                    
                }
                
                CountShow.setTitle( result, for: .normal)
                
                
                
            }else if operation == 14
                
            {
                
                let x =  String(previousNum / numShowOnScreen)
                previousNum = 0 ;
                var hasDot = false
                
                var cc=0
                
                var result = ""
                
                for index in x.characters.indices {
                    
                    if(!hasDot){
                        
                        result+="\(x[index])";
                        
                        if x[index] == "."{
                            
                            hasDot=true;
                            
                        }
                        
                    }else{
                        
                        cc+=1;
                        
                        if(cc<3){
                            
                            result+="\(x[index])";
                            
                        }
                        
                        
                        
                    }
                    
                }
                
                CountShow.setTitle( result, for: .normal)
                
                
                
            }
            
        } else if (sender as AnyObject).tag == 17 && CountShow.currentTitle != nil {
            
            
            
            print("Clear All")
            
            CountShow.setTitle("0", for: .normal)
            
            previousNum = 0;
            
            numShowOnScreen = 0;
            
            operation = 0;
            
        }
        
        
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // UpdateTime()
        
        CountShow.setTitle("0", for: .normal)
        
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



extension Double{
    
    
    
    func truncate(places: Int) -> Double {
        
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
        
        
        
    }
    
    
    
}









