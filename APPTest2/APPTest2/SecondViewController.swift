//
//  SecondViewController.swift
//  APPTest2
//
//  Created by Tengzhe Li on 4/25/17.
//  Copyright © 2017 Tengzhe Li. All rights reserved.
//


import UIKit

class SecondViewController:  UIViewController, UITableViewDelegate,UITableViewDataSource{
    

    var list:[String] = []
    var dateInput:[Date] = []
    var typeOfCell:[Int] = []
    var switcher: Int = 2
    var myIndex = 0
    
    @IBOutlet weak var myTableView: UITableView!
   @IBOutlet weak var SegmentSwitch: UISegmentedControl!
    
    //Switch the tableView in Expense, Income and Total
    @IBAction func SwitchList(_ sender: UISegmentedControl) {
     let a = sender.selectedSegmentIndex
        print("switch \(a)")
     switcher = a
        myTableView.beginUpdates()
        myTableView.endUpdates()
        
    }
    
    //Make Some Table Cell invisible
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height:CGFloat = CGFloat()
        
        if( typeOfCell[indexPath.row] == switcher){
            height = 0
        }else{
        height = 70
        }
        return height
      
    }
    
 

   
    //Refresh Local storage
    public func refreshDate(){
        
        _ = UserDefaults.standard.object(forKey: "plus")
        
        UserDefaults.standard.set(list,forKey: "plus")

        _ = UserDefaults.standard.object(forKey: "time")
        UserDefaults.standard.set(dateInput,forKey: "time")
        
        _ = UserDefaults.standard.object(forKey: "incomeOrExpense")
       UserDefaults.standard.set(typeOfCell,forKey: "incomeOrExpense")
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(list.count)
    }
    
    //Create a new Cell
    public   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        let cell = self.myTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)as!CustomCell
            
        
       //cell.textLabel?.text = list[indexPath.row]
        cell.time.text = list[indexPath.row]
        

        //format
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .short
        dateFormat.timeStyle = .short
     // let stringTime = " \(dateFormat.string(from: dateInput[indexPath.row]))"
       //print (dateInput)
        if (dateInput[indexPath.row] as Date?) != nil   {
        
       cell.name.text = dateFormat.string(from: dateInput[indexPath.row])
        }else{
            cell.name.text = list[indexPath.row]

        }
        
        cell.IncomeOrExpense.text = String(typeOfCell[indexPath.row])
        
        
        if (cell.IncomeOrExpense.text == "0") {
            cell.IncomeOrExpense.textColor = UIColor.red
            let swiftColor = UIColor(red: 10, green: 0, blue: 0, alpha: 0.4)
            cell.backgroundColor=swiftColor
        }else{
        cell.IncomeOrExpense.textColor = UIColor.green
            let swiftColor = UIColor(red: 0, green: 1.0, blue: 0, alpha: 0.3)
            cell.backgroundColor=swiftColor
        }
        //Cell color control
        cell.time.textColor = UIColor.white
        cell.name.textColor = UIColor.yellow
        

      
        return(cell)
    }
    
   func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == editingStyle{
         list.remove(at: indexPath.row)
          dateInput.remove(at: indexPath.row)
            typeOfCell.remove(at: indexPath.row)
            refreshDate()
            myTableView.reloadData()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
     
        
        let plusObject = UserDefaults.standard.object(forKey: "plus")
        list = plusObject as! [String]
        print(plusObject ?? 0)
        
        let dateObject = UserDefaults.standard.object(forKey: "time")
        dateInput = dateObject as! [Date]
        print(dateObject ?? 0)
        
        let IncomeOrExpense = UserDefaults.standard.object(forKey: "incomeOrExpense")
        typeOfCell = IncomeOrExpense as! [Int]
        print(IncomeOrExpense ?? 0)

        myTableView.reloadData()
        SegmentSwitch.reloadInputViews()
      
        
        
    }
    
 //Connect to CustomCell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        myIndex = indexPath.row
        performSegue(withIdentifier: "segue", sender: self)
    }
}
