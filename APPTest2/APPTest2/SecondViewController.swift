//
//  SecondViewController.swift
//  APPTest2
//
//  Created by Tengzhe Li on 4/25/17.
//  Copyright © 2017 Tengzhe Li. All rights reserved.
//
var list:[String] = []
var notificationID:[String] = []
var dateInput:[Date] = []
var typeOfCell:[Int] = []
var amountOfCell:[Double] = []
var typeOfAmount:[Int] = []



var MoneySpent:[Double] = [0,0,0,0,0,0,0,0,0]

var switcher: Int = 0
var myIndex = 0

var timeTag: Int = 0
var tableShow: [Int] = []


import UserNotifications

import UIKit

class SecondViewController:  UIViewController, UITableViewDelegate,UITableViewDataSource{
    
    struct CellStructure {
        var list:String
        var notificationID:String
        var dateInput:Date
        var typeOfCell:Int
        var amountOfCell:Double
        var typeOfAmount:Int
        var tableShow: Int
    }
    var CellArray: [CellStructure] = []
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var SegmentSwitch: UISegmentedControl!
    
    //Switch the tableView in Expense, Income and Total
    @IBAction func SwitchList(_ sender: UISegmentedControl) {
        let a = sender.selectedSegmentIndex
        print("switch \(a)")
        switcher = a
       myTableView.beginUpdates()
       myTableView.endUpdates()
        self.perform(#selector(updateTable), with: nil, afterDelay: 0.8)
    }
    
    //update Table
    func updateTable(){
        print("Update Table")
        self.viewDidAppear(true)
    }

    
    //Make Some Table Cell invisible
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       // var height:CGFloat = CGFloat()
        
        if( typeOfCell[indexPath.row] == switcher){
           // height = 0
            return 0
        }else{
            
            if( tableShow[indexPath.row] == 0){
                return 70
            }else{
                return 0
            }
            
           // return 70
            //height = 70
        }
       // return height
        
    }
    
    
    
    
    //Refresh Local storage
    public func refreshDate(){
        
        _ = UserDefaults.standard.object(forKey: "Add")
        
        UserDefaults.standard.set(list,forKey: "Add")
        
        _ = UserDefaults.standard.object(forKey: "time")
        UserDefaults.standard.set(dateInput,forKey: "time")
        
        _ = UserDefaults.standard.object(forKey: "IncomeOrExpense")
        UserDefaults.standard.set(typeOfCell,forKey: "IncomeOrExpense")
        
        _ = UserDefaults.standard.object(forKey: "UniqueID")
        UserDefaults.standard.set(notificationID,forKey: "UniqueID")
        
        //     _ = UserDefaults.standard.object(forKey: "Description")
        //        UserDefaults.standard.set(Description,forKey: "Description")
        
        _ = UserDefaults.standard.object(forKey: "Amount")
        UserDefaults.standard.set(amountOfCell,forKey: "Amount")
        
        _ = UserDefaults.standard.object(forKey: "InputType")
        UserDefaults.standard.set(typeOfAmount,forKey: "InputType")
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(list.count)
    }
    
    //Create a new Cell
    public   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = self.myTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)as!CustomCell
        
        
        //cell.textLabel?.text = list[indexPath.row]
        cell.name.text = list[indexPath.row]
        
        //Description
        // cell.Description.text = Description[indexPath.row]
        
        //Amount
        cell.Amount.text = String(amountOfCell[indexPath.row])
        print( String(amountOfCell[indexPath.row]))
        //format
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .short
        dateFormat.timeStyle = .short
        // let stringTime = " \(dateFormat.string(from: dateInput[indexPath.row]))"
        //print (dateInput)
        if (dateInput[indexPath.row] as Date?) != nil   {
            
            cell.time.text = dateFormat.string(from: dateInput[indexPath.row])
        }else{
            cell.time.text = list[indexPath.row]
            
        }
        
        if typeOfCell[indexPath.row] == 1 {
            cell.IncomeOrExpense.text = "-"
        }else {
            cell.IncomeOrExpense.text = "+"
        }
        // cell.IncomeOrExpense.text = String(typeOfCell[indexPath.row])
        
        
        if (cell.IncomeOrExpense.text == "-") {
            cell.IncomeOrExpense.textColor = UIColor.red
            
        }else{
            cell.IncomeOrExpense.textColor = UIColor.green
        }
        //Cell color control
        cell.time.textColor = UIColor.black
        cell.name.textColor = UIColor.black
        
        
        
        return(cell)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == editingStyle{
           //index will be new arrayindex
            list.remove(at: indexPath.row)
            dateInput.remove(at: indexPath.row)
            typeOfCell.remove(at: indexPath.row)
            amountOfCell.remove(at: indexPath.row)
            // Description.remove(at: indexPath.row)
            typeOfAmount.remove(at: indexPath.row)
            //Delete the notification
            let center = UNUserNotificationCenter.current()
            center.removePendingNotificationRequests(withIdentifiers: [notificationID[indexPath.row]])
            //.......
            print("removed uuid: \(notificationID[indexPath.row])")
            notificationID.remove(at: indexPath.row)
           
            refreshDate()
            MoneySpent = [0,0,0,0,0,0,0,0,0]
            moneySpent()
            myTableView.reloadData()
        }
    }
    
    func moneySpent(){
        for (index, _) in typeOfAmount.enumerated() {
            if typeOfAmount[index] == 0 {
                MoneySpent[0] +=  amountOfCell[index]
            }
        }
        for (index, _) in typeOfAmount.enumerated() {
            if typeOfAmount[index] == 1 {
                MoneySpent[1] +=  amountOfCell[index]
            }
        }
        
        for (index, _) in typeOfAmount.enumerated() {
            if typeOfAmount[index] == 2 {
                MoneySpent[2] +=  amountOfCell[index]
            }
        }
        for (index, _) in typeOfAmount.enumerated() {
            if typeOfAmount[index] == 3 {
                MoneySpent[3] +=  amountOfCell[index]
            }
        }
        
        for (index, _) in typeOfAmount.enumerated() {
            if typeOfAmount[index] == 4 {
                MoneySpent[4] +=  amountOfCell[index]
            }
        }
        for (index, _) in typeOfAmount.enumerated() {
            if typeOfAmount[index] == 5 {
                MoneySpent[5] +=  amountOfCell[index]
            }
        }
        for (index, _) in typeOfAmount.enumerated() {
            if typeOfAmount[index] == 6 {
                MoneySpent[6] +=  amountOfCell[index]
            }
        }
        for (index, _) in typeOfAmount.enumerated() {
            if typeOfAmount[index] == 7 {
                MoneySpent[7] +=  amountOfCell[index]
            }
        }
        for (index, _) in typeOfAmount.enumerated() {
            if typeOfAmount[index] == 8 {
                MoneySpent[8] +=  amountOfCell[index]
            }
        }
        
        
        
        
        print(MoneySpent)
    }
    
    
    func TimeRange(){
        print("Second View Time range")
     //   let todayDate = Date()
        let calendar = NSCalendar.current
      //  let date1 = calendar.startOfDay(for: todayDate)
        
        
        if(timeTag == 2){
            let FirstDayWeek = Date().startOfWeek()
            
            //Comparing Date List element with current Date
            for  t in dateInput{
                let ToStart = calendar.dateComponents([.day], from: FirstDayWeek, to: t)
                
                if(ToStart.day! <= 7 && ToStart.day! >= 0){
                    tableShow.append(0)
                }else{
                    tableShow.append(1)
                }
            }
        }else if(timeTag == 1){
            let Today = Date()
            for  t in dateInput{
                let ToStart = calendar.dateComponents([.day], from: Today, to: t)
                print(ToStart.day!)
                if(ToStart.day! == 0){
                    tableShow.append(0)
                }else{
                    tableShow.append(1)
                }
            }
        }else if(timeTag == 3){
            let FirstDayMonth = Date().startOfMonth()
            let LastDayMonth = Date().endOfMonth()
            
            //Geting How many days in this Month
            let MonthDay = calendar.dateComponents([.day], from: FirstDayMonth, to: LastDayMonth)
            print("There are\(MonthDay.day!) in this Month!")
            
            //Comparing Date List element with current Date
            for  t in dateInput{
                let ToStart = calendar.dateComponents([.day], from: FirstDayMonth, to: t)
                print(ToStart.day!)
                if(ToStart.day! <= MonthDay.day! && ToStart.day! >= 0){
                    tableShow.append(0)
                }else{
                    tableShow.append(1)
                }
            }
        }else if (timeTag == 0){
            for  _ in dateInput{
            tableShow.append(0)
                
            }
        }
        
        print(tableShow)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        //Put all local storage to local variable
        
        let plusObject = UserDefaults.standard.object(forKey: "Add")
        if (plusObject as? [String]) != nil{
            list = plusObject as! [String]
            print(plusObject ?? 0)
        }
        
        
        let dateObject = UserDefaults.standard.object(forKey: "time")
        if (dateObject as? [Date]) != nil{
            dateInput = dateObject as! [Date]
            print(dateObject ?? 0)
        }
        
        
        let IncomeOrExpense = UserDefaults.standard.object(forKey: "IncomeOrExpense")
        if (IncomeOrExpense as? [Int]) != nil{
            typeOfCell = IncomeOrExpense as! [Int]
            print(IncomeOrExpense ?? 0)
        }
        
        let UUIDObject = UserDefaults.standard.object(forKey: "UniqueID")
        if (UUIDObject as? [String]) != nil{
            notificationID = UUIDObject as! [String]
            print(UUIDObject ?? 0)
        }
        
        
        
        let amountObject = UserDefaults.standard.object(forKey: "Amount")
        if (amountObject as? [Double]) != nil{
            amountOfCell = amountObject as! [Double]
            print(amountObject ?? 0)
        }
        
        let typeObject = UserDefaults.standard.object(forKey: "InputType")
        
        if (typeObject as? [Int]) != nil{
            typeOfAmount = typeObject as! [Int]
            print(typeOfAmount )
        }
        
        let Tag = UserDefaults.standard.object(forKey: "TimeRangeTag")
        if(Tag as? Int) != nil{
            timeTag = Tag as! Int
        }
        
        tableShow = []
        TimeRange()
        
///
        if(list.count != 0){
            for  i in (0..<list.count).reversed() {
     ///dont use this structure use that old one 
                let a = CellStructure(list:list[i], notificationID: notificationID[i], dateInput: dateInput[i], typeOfCell: typeOfCell[i], amountOfCell: amountOfCell[i], typeOfAmount: typeOfAmount[i], tableShow: tableShow[i])
                CellArray.append(a)
            }
        }
        
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .short
        dateFormat.timeStyle = .short
        
        for i in 0..<CellArray.count{
            print(dateFormat.string(from: CellArray[i].dateInput))
            
        }
        CellArray = CellArray.sorted(by: {$0.dateInput<$1.dateInput})
        // CellArray = CellArray.sorted(by: {$0.amountOfCell<$1.amountOfCell})
        for i in 0..<CellArray.count{
            print("Next\(dateFormat.string(from: CellArray[i].dateInput))")
            
        }
    /////
        moneySpent()
        myTableView.reloadData()
        SegmentSwitch.reloadInputViews()
        
    }
    
    
    @IBAction func TimeSwitchTag(_ sender: Any) {
        
        performSegue(withIdentifier: "segue4", sender: self)
        
        
        
    }
    
    //Connect to CustomCell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        myIndex = indexPath.row
        performSegue(withIdentifier: "segue", sender: self)
    }
}
