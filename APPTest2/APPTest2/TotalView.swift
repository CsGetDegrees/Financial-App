//
//  TotalView.swift
//  Budgetable
//
//  Created by Tengzhe Li on 21/09/17.
//  Copyright © 2017 Tengzhe Li. All rights reserved.
//

import Foundation
import UIKit


class TotalView: UIViewController , UITableViewDelegate, UITableViewDataSource, ExpandableHeaderViewDelegate{
    
    @IBOutlet weak var AddButton: UIButton!
    
    var list: [String]! = []
    var listIncome: [String]! = []
    var listExpense: [String]! = []
    
    //let listEx:[String]! = ["1","2","3","4","5"]
    
    var InOrExList:[Int] = [1,2,3]
    
    var TypeList:[Int] = []
    var IncomeType:[Int] = []
    var ExpenseType:[Int] = []
    
    var TimeList:[Date] = []
    var IncomeTime:[Date] = []
    var ExpenseTime:[Date] = []
    
    var AmountList:[Double] = []
    var IncomeAmount:[Double] = []
    var ExpenseAmount:[Double] = []
    
    var timeRangeSwitch: Int = 0
    
    var sections = [Section(genre: "Income", movies: [], expanded: false, type: [], amount: [], time: [], display: []),
                    Section(genre: "Expense", movies: [], expanded: false, type: [], amount: [], time: [], display: [])]
    
    var timeTag: Int = 0
    var tableShow: [Int] = []
    var IncomeShow: [Int] = []
    var ExpenseShow: [Int] = []
    

    @IBOutlet weak var IncomeTable: UITableView!
    
    var listCount: Int = 0
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        if tableView.tag == 2{
            return sections.count
        }else{
            return 1
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      //  print(".")
        //Need to be fit
        if tableView.tag == 0{
            // return(list.count)
            print(list)
            listCount = list.count
            return listCount
        }else if tableView.tag == 2 {
            //Table with header
            return sections[section].movies.count
            // return(listIncome.count)
        }else{
            return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if sections[indexPath.section].expanded == true{
            let todayDate = Date()
            let selectDate = sections[indexPath.section].time[0]
            
            let currentWeekday = Calendar.current.component(.weekday, from: todayDate)
            //need -1 ?
            print(currentWeekday)
           
            let calendar = NSCalendar.current
            let FirstDayMonth = Date().startOfMonth()
            let LastDayMonth = Date().endOfMonth()
            let FirstDayWeek = Date().startOfWeek()
            
            
            //Need add 1
            let LastDayWeek = Date().endOfWeek()
            let LastDayMonth2 = Date().getThisMonthEnd()
            
            
            // Replace the hour (time) of both dates with 00:00
            let date1 = calendar.startOfDay(for: todayDate)
            let date2 = calendar.startOfDay(for: selectDate)
            
            let components = calendar.dateComponents([.day], from: date1, to: FirstDayWeek)
           print(components.day!)
            
            if(sections[indexPath.section].display[indexPath.row] == 0){
                    return 48
            }else{
            return 0
            }
  
        }else{
            return 0
        }
    }
    

    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandableHeaderView()
        header.customInit(title: sections[section].genre, section: section, delegate: self as ExpandableHeaderViewDelegate)
        return header
    }
    
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // print("FK!!!!")
        
        if tableView.tag == 2{
            
            let  cell = self.IncomeTable.dequeueReusableCell(withIdentifier: "cellHeader", for: indexPath)as! HeaderViewCell
            
            // cell.Name.text = listIncome[indexPath.row]
            cell.Name.text = sections[indexPath.section].movies[indexPath.row]
            cell.CellType.text = String(sections[indexPath.section].type[indexPath.row])
            cell.Amount.text = String(sections[indexPath.section].amount[indexPath.row])
            //format
            let dateFormat = DateFormatter()
             dateFormat.locale = Locale(identifier: "en_GB")
           dateFormat.setLocalizedDateFormatFromTemplate("MMMd")
            //dateFormat.dateStyle = .short
            //dateFormat.timeStyle = .short

            if (sections[indexPath.section].time[indexPath.row] as Date?) != nil   {
                
                cell.Time.text = dateFormat.string(from: sections[indexPath.section].time[indexPath.row])
            }
            
            print(sections[0].type)
            //  cell.CellType.text = sections[indexPath.section].type[indexPath.row]
            // var a = sections[indexPath.section].type[indexPath.row]
            //print(a)
            return(cell)
            
            
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)as UITableViewCell
            
            return (cell)
        }
    }
    
    func toggleSection(header: ExpandableHeaderView, section: Int) {
        sections[section].expanded = !sections[section].expanded
        
        IncomeTable.beginUpdates()
        for i in 0 ..< sections[section].movies.count{
            IncomeTable.reloadRows(at: [IndexPath(row: i, section:section)], with: .automatic)
        }
        IncomeTable.endUpdates()
     //  self.viewDidAppear(true)
    }
    
    @IBAction func changeMovies(_ sender: Any) {
      //  sections[0].movies = list
      //  self.IncomeTable.reloadData()
        //self.viewWillAppear(true)
       // self.viewDidLoad()
        self.viewDidAppear(true)
        
        // sections[1].expanded = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         print("ViewDidLoad")
        if(timeRangeSwitch == 0){
        //AddButton.layer.zPosition = 101;
        print("ViewDidLoad")
        }else{
        return
        }
    }
    
    func TimeRange(){
        let todayDate = Date()
        // let selectDate = sections[indexPath.section].time[0]
        let currentWeekday = Calendar.current.component(.weekday, from: todayDate)
        print(currentWeekday)
        let calendar = NSCalendar.current
        let date1 = calendar.startOfDay(for: todayDate)
        //let date2 = calendar.startOfDay(for: selectDate)
        if(timeTag == 2){
            let FirstDayWeek = Date().startOfWeek()
            //Need add 1
            let LastDayWeek = Date().endOfWeek()
            
            let CurrentToStart = calendar.dateComponents([.day], from: FirstDayWeek, to:date1)
            let CurrentToEnd = calendar.dateComponents([.day], from: date1, to: LastDayWeek)
            let start: Int = CurrentToStart.day!
            let end: Int = (CurrentToEnd.day!)+1
            print(start)
            print(end)
            
            for  t in TimeList{
                      let ToStart = calendar.dateComponents([.day], from: FirstDayWeek, to: t)
                print(ToStart.day!)
                if(ToStart.day! <= 7){
                print("hahha")
                    tableShow.append(0)
                }else{
                print("NO")
                    tableShow.append(1)
                }
            }
        }
        print(tableShow)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Empty the local variable
        list = []
        InOrExList = []
        TypeList = []
        AmountList = []
        TimeList = []
        listIncome  = []
         tableShow = []
        
        IncomeType = []
        IncomeAmount = []
        IncomeTime = []
        listExpense = []
        ExpenseType = []
        ExpenseAmount = []
        ExpenseTime = []
       
        IncomeShow = []
        ExpenseShow = []
        
        //Put all local storage to local variable
        let AddObject = UserDefaults.standard.object(forKey: "Add")
        if (AddObject as? [String]) != nil{
            list = AddObject as! [String]
           // print(AddObject ?? 0)
        }
        
        let IncomeOrExpense = UserDefaults.standard.object(forKey: "IncomeOrExpense")
        if (IncomeOrExpense as? [Int]) != nil{
            InOrExList = IncomeOrExpense as! [Int]
           // print(IncomeOrExpense ?? 0)
        }
        
        let InputType = UserDefaults.standard.object(forKey: "InputType")
        if (InputType as? [Int]) != nil{
            TypeList = InputType as! [Int]
           // print(InputType ?? 0)
        }
        
        let amountObject = UserDefaults.standard.object(forKey: "Amount")
        if (amountObject as? [Double]) != nil{
            AmountList = amountObject as! [Double]
            //print(amountObject ?? 0)
        }
        
        let dateObject = UserDefaults.standard.object(forKey: "time")
        if (dateObject as? [Date]) != nil{
            TimeList = dateObject as! [Date]
            //print(TimeList )
        }
        
        let timeSwitch = UserDefaults.standard.object(forKey: "TimeSwitch")
        if(timeSwitch as? Int) != nil{
        timeRangeSwitch = timeSwitch as! Int
            print(timeRangeSwitch)
        }
        
        let Tag = UserDefaults.standard.object(forKey: "TimeRangeTag")
        if(Tag as? Int) != nil{
            timeTag = Tag as! Int
        }

         TimeRange()
        
        //Assign value to Income and Expense Section
        if(list.count != 0){
            for  i in (0..<list.count).reversed() {
                if(InOrExList[i] == 0){
                    listIncome.append(list[i])
                    IncomeType.append(TypeList[i])
                    IncomeAmount.append(AmountList[i])
                    IncomeTime.append(TimeList[i])
                    if(tableShow.count != 0){
                    IncomeShow.append(tableShow[i])
                    }else{
                    IncomeShow.append(0)
                    }
                }else{
                    listExpense.append(list[i])
                    ExpenseType.append(TypeList[i])
                    ExpenseAmount.append(AmountList[i])
                    ExpenseTime.append(TimeList[i])
                    if (tableShow.count != 0) {
                     
                    ExpenseShow.append(tableShow[i])
                    }else{
                    ExpenseShow.append(0)
                    }
                }
            }
        }
        sections[0].movies = listIncome
        sections[1].movies = listExpense
        sections[0].type = IncomeType
        sections[1].type = ExpenseType
        sections[0].amount = IncomeAmount
        sections[1].amount = ExpenseAmount
        sections[0].time = IncomeTime
        sections[1].time = ExpenseTime
        sections[0].display = IncomeShow
        sections[1].display = ExpenseShow

        
        //Do not load table when open time select view
        if(timeRangeSwitch == 0){
            
            self.IncomeTable.reloadData()
        }
        
        print(listIncome)
        print(listExpense)
        print(IncomeType)
        print(ExpenseType)
        print(IncomeAmount)
        print(ExpenseAmount)
        print(IncomeTime)
        print(ExpenseTime)
        print("Time tag \(timeTag)")
        print(IncomeShow)
        print(ExpenseShow)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        print("22")
    }
    //Connect to CustomCell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        print(indexPath)
        
        //  performSegue(withIdentifier: "segue", sender: self)
    }
    
    @IBAction func AddNew(_ sender: Any) {
        performSegue(withIdentifier: "segue", sender: self)
        
    }
    @IBAction func TimeRangeSelect(_ sender: Any) {
        timeRangeSwitch = 1
        _ = UserDefaults.standard.object(forKey: "TimeSwitch")
        var TSwitch:Int
        TSwitch = timeRangeSwitch
        UserDefaults.standard.set(TSwitch,forKey: "TimeSwitch")
        performSegue(withIdentifier: "segue3", sender: self)
    }
    
//    @IBAction func Today(_ sender: Any) {
//        let tag: Int = (sender as AnyObject).tag
//
//        timeRangeSwitch = 0
//        _ = UserDefaults.standard.object(forKey: "TimeSwitch")
//        var TSwitch:Int
//        TSwitch = timeRangeSwitch
//        UserDefaults.standard.set(TSwitch,forKey: "TimeSwitch")
//    
//        //Saveing Time tag to local storage for switching time range for table view
//        _ = UserDefaults.standard.object(forKey: "TimeRangeTag")
//        var TTag:Int
//        TTag = tag
//        UserDefaults.standard.set(TTag,forKey: "TimeRangeTag")
//         print(TTag)
//    self.dismiss(animated: true, completion: nil)
//        
//        
//    }
    
    //how to update Table after segue 
    func updateTable(){
        print("Update Table")
    // self.IncomeTable.reloadData()
          //self.viewDidAppear(true)
       // TimeRange()
    }
}

//extensed method for helping get dateRange
extension Date {
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    
    func startOfWeek() -> Date{
        return Calendar.current.date(from: Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))!
    }
    func startOfWeek2() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.yearForWeekOfYear,.weekOfYear], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfWeek() -> Date{
        return Calendar.current.date(byAdding: DateComponents(weekday: -1, weekOfYear: 1), to: self.startOfWeek2())!
    }
    
    //Another way
    func getThisMonthEnd() -> Date? {
        let components:NSDateComponents = Calendar.current.dateComponents([.year, .month], from: self) as NSDateComponents
        components.month += 1
        components.day = 1
        components.day -= 1
        return Calendar.current.date(from: components as DateComponents)!
    }
    
}
