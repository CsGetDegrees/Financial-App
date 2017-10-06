//
//  TotalView.swift
//  Budgetable

//  This is the main page view controller.

//  Created by Tengzhe Li on 21/09/17.
//  Copyright © 2017 TopCat. All rights reserved.
//

import Foundation
import UIKit
import Charts


class TotalView: UIViewController , UITableViewDelegate, UITableViewDataSource, ExpandableHeaderViewDelegate{
    
    @IBOutlet weak var NavBar: UINavigationBar!
    @IBOutlet weak var AddButton: UIButton!
    
    @IBOutlet weak var TimePeriod: UILabel!
    @IBOutlet weak var Budget: UILabel!
   
    @IBOutlet weak var SavingGoal: UILabel!
    
    
    
    var list: [String]! = []
    
    var InOrExList:[Int] = []
    var TypeList:[Int] = []
    var TimeList:[Date] = []
    var AmountList:[Double] = []
    var timeRangeSwitch: Int = 0
    var notificationID: [String] = []
    
    var ArrayCell: [sectionCell] = []
    var IncomeCell: [sectionCell] = []
    var ExpenseCell: [sectionCell] = []
    
    var IncomeValue: Double = 0.0
    var ExpenseValue: Double = 0.0
    var MoneyLeft: Double = 0.0

   
    @IBOutlet weak var barChartView: BarChartView!
    var sections = [Section(genre: "Income", expanded: false, cell:[]),
                    Section(genre: "Expense", expanded: false, cell: [])]
    
    var timeTag: Int = 0
    var sortTag: Int = 0
    
    var tableShow: [Int] = []

    var WeekGoal:Double = 0.0
    var WeekBudget:Double = 0.0
    var MonthGoal: Double = 0.0
    var MonthBudget: Double = 0.0
    var Goal: Double = 0.0
    
    // a list of expense types
    var listEx: [String]! = ["Bills","Transport","Clothes","EatingOut","Entertainment","Health","Food","Pet","House","Else"]
    // imcome types array
    var listIn: [String]! = ["Deposits","Salary","Saving"]
    
    
    @IBOutlet weak var IncomeTable: UITableView!
    
    var listCount: Int = 0
    // the number of sections would be appered on the first page
    public func numberOfSections(in tableView: UITableView) -> Int {
            return sections.count
       
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //  print(".")
        //Need to be fit
        if tableView.tag == 2 {
            //Table with header
            //Change ..
            return sections[section].cell.count
        }else{
            return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if sections[indexPath.section].expanded == true{
            //Change ..
//            if(sections[indexPath.section].display[indexPath.row] == 0){
//                return 48
//            }else{
//                return 0
//            }
            return 50
        }else{
            return 0
        }
    }
    
    
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       
        
        let InValue = "Income: $" + String(IncomeValue)
        if sections[0].genre  != InValue{
            sections[0].genre = InValue
        }
        
        let ExValue = "Expense: $" + String(ExpenseValue)
        if sections[1].genre != ExValue{
            sections[1].genre = ExValue
        }

        let header = ExpandableHeaderView()
        header.customInit(title: sections[section].genre, section: section, delegate: self as ExpandableHeaderViewDelegate)
        return header
    }
    
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        if tableView.tag == 2{
            
            let  cell = self.IncomeTable.dequeueReusableCell(withIdentifier: "cellHeader", for: indexPath)as! HeaderViewCell
            
          //  cell.Name.text = sections[indexPath.section].cell[indexPath.row].list
            cell.CellType.text = String(sections[indexPath.section].cell[indexPath.row].amountOfCell)
           
            if(sections[indexPath.section].cell[indexPath.row].typeOfAmount == 0){
                var i = sections[indexPath.section].cell[indexPath.row].typeOfCell
                
                 cell.Amount.text = String(listIn[i])
            }else{
                var i = sections[indexPath.section].cell[indexPath.row].typeOfCell
                
                cell.Amount.text = String(listEx[i])
                
            }
            
         //   cell.Amount.text = String(sections[indexPath.section].cell[indexPath.row].typeOfCell)
            
            //format
            let dateFormat = DateFormatter()
            dateFormat.locale = Locale(identifier: "en_GB")
            dateFormat.setLocalizedDateFormatFromTemplate("MMMd")
            //dateFormat.dateStyle = .short
            //dateFormat.timeStyle = .short
            
            if (sections[indexPath.section].cell[indexPath.row].dateInput as Date?) != nil   {
                
                cell.Time.text = dateFormat.string(from: sections[indexPath.section].cell[indexPath.row].dateInput)
            }
            

            return(cell)
            
            
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)as UITableViewCell
            
            return (cell)
        }
    }
    func setBarChart(saved: Double, range: Double,  color : NSUIColor){
        barChartView.drawBarShadowEnabled = false
        barChartView.drawValueAboveBarEnabled = false
        barChartView.maxVisibleCount = 100
        
        let xAxis  = barChartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.drawAxisLineEnabled = false
        xAxis.drawGridLinesEnabled = false
        
        xAxis.granularity = 0.0
        xAxis.enabled = false
        
        let leftAxis = barChartView.leftAxis;
        
        leftAxis.drawAxisLineEnabled = false;
        
        leftAxis.drawGridLinesEnabled = false;
        
        leftAxis.axisMinimum = 0.0; // this replaces startAtZero = YES
        
        leftAxis.enabled = false;
        
        let rightAxis = barChartView.rightAxis
        
        rightAxis.enabled = false;
        
        
        
        rightAxis.drawAxisLineEnabled = false;
        
        rightAxis.drawGridLinesEnabled = false;
        
        rightAxis.axisMinimum = 0.0; // this replaces startAtZero = YES
        rightAxis.enabled = false;
        
        let l = barChartView.legend
        l.enabled =  false
        
        barChartView.fitBars = true;
        barChartView.drawValueAboveBarEnabled = false;
        print("LLLLLLLLLLL")
                  barChartView.animate(yAxisDuration: 1.5, easingOption: .easeInOutQuart)
        print(saved,range)
        setDataCount(saved: saved, range:range, color:color)
    }
    
    
    // support function for the bar chart.
    // saved : how much the user has saved.
    // range : how much the user wants to save.
    func setDataCount( saved: Double, range: Double, color : NSUIColor){
        
        print("LLLLLLIIIIIIII")
          print(saved,range)
        let barWidth = 9.0
        
        let spaceForBar =  10.0;
        
        var yVals = [BarChartDataEntry]()
        
        yVals.append(BarChartDataEntry(x: Double(0) * spaceForBar, y: saved))
        
        
        
        yVals.append(BarChartDataEntry(x: Double(1) * spaceForBar, y: range))
        
        
        var set1 : BarChartDataSet!
        
        if let count = barChartView.data?.dataSetCount, count > 0{
            
            set1 = barChartView.data?.dataSets[0] as! BarChartDataSet
            
            set1.values = yVals
              set1.colors=[color,NSUIColor.white]
            
            print("kkkoooo")
            barChartView.chartDescription?.text = ""
            
            barChartView.data?.notifyDataChanged()
            
            barChartView.notifyDataSetChanged()
            
//            print("okkk")
//            set1 = BarChartDataSet(values: yVals, label: "")
//            // colors of bars
//            set1.colors=[color,NSUIColor.white]
//            var dataSets = [BarChartDataSet]()
//            
//            dataSets.append(set1)
//            
//            
//            
//            let data = BarChartData(dataSets: dataSets)
//            
//            data.setDrawValues(false)
//            data.barWidth =  barWidth;
//            
//            
//            
//            barChartView.data = data
//            
//            barChartView.isUserInteractionEnabled = false;
//            barChartView.animate(yAxisDuration: 1.5, easingOption: .easeInOutQuart)
//            barChartView.notifyDataSetChanged()
            
            
        }else{
                print("okkk")
            set1 = BarChartDataSet(values: yVals, label: "")
            // colors of bars
            set1.colors=[color,NSUIColor.white]
            var dataSets = [BarChartDataSet]()
            
            dataSets.append(set1)
            
            
            
            let data = BarChartData(dataSets: dataSets)
            
            data.setDrawValues(false)
            data.barWidth =  barWidth;
            
            
            
            barChartView.data = data
            
            barChartView.isUserInteractionEnabled = false;
            barChartView.animate(yAxisDuration: 1.5, easingOption: .easeInOutQuart)
              barChartView.notifyDataSetChanged()
            
        }
        
        
    }

    // hide and show toggle.
    func toggleSection(header: ExpandableHeaderView, section: Int) {
        sections[section].expanded = !sections[section].expanded
        
        IncomeTable.beginUpdates()
        for i in 0 ..< sections[section].cell.count{
            IncomeTable.reloadRows(at: [IndexPath(row: i, section:section)], with: .automatic)
        }
        IncomeTable.endUpdates()
        self.perform(#selector(updateTable), with: nil, afterDelay: 0.3)
        //  self.viewDidAppear(true)
    }
    
    //update Table
    func updateTable(){
        print("Update Table")
        // self.IncomeTable.reloadData()
        self.viewDidAppear(true)
    }
    
    @IBOutlet weak var descriptionLabel: UILabel!
    //Just Update
    @IBAction func changeMovies(_ sender: Any) {
        self.viewDidAppear(true)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setBarChart(saved: 5, range: 10, color: NSUIColor.blue)
//        barChartView.notifyDataSetChanged()
        print("ViewDidLoad")
//        barChartView.notifyDataSetChanged()
            AddButton.layer.zPosition = 101;
        NavBar.layer.zPosition = 1;
            print("ViewDidLoad")
     
    }
    
    //Need to be fit
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

            //Comparing Date List element with current Date
            for  t in TimeList{
                let ToStart = calendar.dateComponents([.day], from: FirstDayWeek, to: t)
                print(ToStart.day!)
                if(ToStart.day! <= 7 && ToStart.day! >= 0){
                    tableShow.append(0)
                }else{
                    tableShow.append(1)
                }
            }
        }else if(timeTag == 1){
            let Today = Date()
            let CurrentToStart = calendar.dateComponents([.day], from: Today, to:date1)
            let start: Int = CurrentToStart.day!
    
            
            for  t in TimeList{
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
            //Need add 1
            let LastDayMonth = Date().endOfMonth()
            
            let CurrentToStart = calendar.dateComponents([.day], from: FirstDayMonth, to:date1)
            let CurrentToEnd = calendar.dateComponents([.day], from: date1, to: LastDayMonth)
            let start: Int = CurrentToStart.day!
            let end: Int = (CurrentToEnd.day!)+1

            //Geting How many days in this Month
            let MonthDay = calendar.dateComponents([.day], from: FirstDayMonth, to: LastDayMonth)
     print("There are\(MonthDay.day!) in this Month!")
            //Comparing Date List element with current Date
            for  t in TimeList{
                let ToStart = calendar.dateComponents([.day], from: FirstDayMonth, to: t)
                print(ToStart.day!)
                if(ToStart.day! <= MonthDay.day! && ToStart.day! >= 0){
                    tableShow.append(0)
                }else{
                    tableShow.append(1)
                }
            }
        }else if(timeTag == 0 ){
            for  _ in TimeList{
                tableShow.append(0)
            }
            
        }
        
        print(tableShow)
    }
    
    func CountTotal(){
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
        list = []
        InOrExList = []
        TypeList = []
        AmountList = []
        TimeList = []
       
        tableShow = []
        

        
        ArrayCell = []
        IncomeCell = []
        ExpenseCell = []
        
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
        
        let Tag = UserDefaults.standard.object(forKey: "TimeRangeTag")
        if(Tag as? Int) != nil{
            timeTag = Tag as! Int
        }
        
        let SortingTag = UserDefaults.standard.object(forKey: "SortingTag")
        if(SortingTag as? Int) != nil{
            sortTag = SortingTag as! Int
            print("sort \(sortTag)")
        }
        
        let UUIDObject = UserDefaults.standard.object(forKey: "UniqueID")
        if (UUIDObject as? [String]) != nil{
            notificationID = UUIDObject as! [String]
            print(UUIDObject ?? 0)
        }
        
        /*1.Merge Time within Type
         *2.Then description will not be showed in this view
         *3.Date of element will be refresh when custom pushed
         *at last time(Same type only has one date).
         *4.Budget element can be deleted Anytime.
         *5.If element is deleted, the corresponding history
         * will be deleted as well.
         *6.Conclusion This table can only show element with type.
         * After click it, there will be a report showed in another view. Report can include history of this type, final update date and corresponding description. However customer can not edit it. They can only edit transation history in history table.
         *7.Piggy bank picture with different face.
         *8.Bar chart with different color
         */
        /*if same type..get the sequence of date, select last date before current as date element. Add all element' name to
            a string element as description. Add all amount to total as
            new amount.Nope!
        */
        /* only has 2 tag week and month. 2 budget saving goal for custom.Empty when the start of week and month. After week or month(only can select one).The money you save will be save in a can in setting view. Total goal can only be add weekly.*/
        
        
        TimeRange()
        //All Good
        if(list.count != 0){
            for  i in (0..<list.count).reversed() {
                print(tableShow)
                if(tableShow[i] == 0){
                    let a = sectionCell(list:list[i], dateInput: TimeList[i], typeOfCell: TypeList[i], amountOfCell: AmountList[i], typeOfAmount: InOrExList[i],tableShow: tableShow[i], notificationID: notificationID[i])
                ArrayCell.append(a)
               }
            }
        }
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .short
        dateFormat.timeStyle = .short
        
        for i in 0..<ArrayCell.count{
            print(dateFormat.string(from: ArrayCell[i].dateInput))
        }
        
       
        /////
        if ArrayCell.count > 0{
        for i in 0..<ArrayCell.count{
            //let j = i+1
            for j in 0..<ArrayCell.count{
                if ArrayCell[i].typeOfCell == ArrayCell[j].typeOfCell && ArrayCell[i].notificationID != ArrayCell[j].notificationID && ArrayCell[i].tableShow != 1 && ArrayCell[i].typeOfAmount == ArrayCell[j].typeOfAmount{
                    //Unique ID
                    ArrayCell[i].amountOfCell += ArrayCell[j].amountOfCell
                    ArrayCell[i].dateInput = ArrayCell[j].dateInput
                   // ArrayCell[i].notificationID = ArrayCell[j].notificationID
                    ArrayCell[j].tableShow = 1
                    ArrayCell[i].list += ArrayCell[j].list
                    
                }
            }
        }
            
        }
        
     
        
        for i in 0..<ArrayCell.count{
            if ArrayCell[i].tableShow != 1{
            if(ArrayCell[i].typeOfAmount == 0){
                IncomeCell.append(ArrayCell[i])
            }else{
                ExpenseCell.append(ArrayCell[i])
            }
            }
        }
        
   
        
       // if sortTag == 1{
        IncomeCell = IncomeCell.sorted(by: {$0.dateInput<$1.dateInput})
        ExpenseCell = ExpenseCell.sorted(by: {$0.dateInput<$1.dateInput})
//        } else if sortTag == 2{
//            IncomeCell = IncomeCell.sorted(by: {$0.amountOfCell<$1.amountOfCell})
//            ExpenseCell = ExpenseCell.sorted(by: {$0.amountOfCell<$1.amountOfCell})
//        }else if sortTag == 3{
//            IncomeCell = IncomeCell.sorted(by: {$0.typeOfAmount < $1.typeOfAmount})
//            ExpenseCell = ExpenseCell.sorted(by: {$0.typeOfAmount<$1.typeOfAmount})
//        }
        
        
        for i in 0..<IncomeCell.count{
            print("In")
            print(dateFormat.string(from: IncomeCell[i].dateInput))
        }
        for i in 0..<ExpenseCell.count{
            print("Ex")
            print(dateFormat.string(from: ExpenseCell[i].dateInput))
        }
  
        IncomeValue = 0.0
        ExpenseValue = 0.0
        
        for i in 0..<IncomeCell.count{
            IncomeValue += IncomeCell[i].amountOfCell
        }
        for i in 0..<ExpenseCell.count{
            ExpenseValue += ExpenseCell[i].amountOfCell
        }
         print(IncomeValue)
        print(ExpenseValue)
        
        
        
        sections[0].cell = IncomeCell
        sections[1].cell = ExpenseCell
        //Make an Array[sectionCell] Then assign in to section
        
      //  Assign value to Income and Expense Section
//        if(list.count != 0){
//            for  i in (0..<list.count).reversed() {
//                if(InOrExList[i] == 0){
//                    listIncome.append(list[i])
//                    IncomeType.append(TypeList[i])
//                    IncomeAmount.append(AmountList[i])
//                    IncomeTime.append(TimeList[i])
//                    if(tableShow.count != 0){
//                        IncomeShow.append(tableShow[i])
//                    }else{
//                        IncomeShow.append(0)
//                    }
//                }else{
//                    listExpense.append(list[i])
//                    ExpenseType.append(TypeList[i])
//                    ExpenseAmount.append(AmountList[i])
//                    ExpenseTime.append(TimeList[i])
//                    if (tableShow.count != 0) {
//                        ExpenseShow.append(tableShow[i])
//                    }else{
//                        ExpenseShow.append(0)
//                    }
//                }
//            }
//        }
        
        
//        sections[0].movies = listIncome
//        sections[1].movies = listExpense
//        sections[0].type = IncomeType
//        sections[1].type = ExpenseType
//        sections[0].amount = IncomeAmount
//        sections[1].amount = ExpenseAmount
//        sections[0].time = IncomeTime
//        sections[1].time = ExpenseTime
//        sections[0].display = IncomeShow
//        sections[1].display = ExpenseShow
        
       
            self.IncomeTable.reloadData()
        
        let goalObject = UserDefaults.standard.object(forKey: "Goal")
        if (goalObject as? Double) != nil{
            WeekGoal = goalObject as! Double
        }
        
        let holdObject = UserDefaults.standard.object(forKey: "Hold")
        if (holdObject as? Double) != nil{
            WeekBudget = holdObject as! Double
        }
        
        let MonthGoalObject = UserDefaults.standard.object(forKey: "MonthGoal")
        if (MonthGoalObject as? Double) != nil{
            MonthGoal = MonthGoalObject as! Double
        }
        
        let MonthBudgetObject = UserDefaults.standard.object(forKey: "MonthBudget")
        if (MonthBudgetObject as? Double) != nil{
            MonthBudget = MonthBudgetObject as! Double
        }
        
        let FinalGoalObject = UserDefaults.standard.object(forKey: "FinalGoal")
        if (MonthBudgetObject as? Double) != nil{
            Goal = FinalGoalObject as! Double
        }
        
        // money holding if time tag is week or month
        //otherwise just show default weekbudget 50% Saving and rest of money
        
        if timeTag != 1 && timeTag != 0{

            if timeTag == 2{
        WeekBudget += IncomeValue
        MoneyLeft = WeekBudget - ExpenseValue
                let todayDate = Date()
                let currentWeekday = Calendar.current.component(.weekday, from: todayDate)
                print(currentWeekday)

                let calendar = NSCalendar.current
                let date1 = calendar.startOfDay(for: todayDate)

                if(timeTag == 2){
                    let FirstDayWeek = Date().startOfWeek()
                    let LastDayWeek = Date().endOfWeek()

                    let CurrentToStart = calendar.dateComponents([.day], from: FirstDayWeek, to:date1)
                    let CurrentToEnd = calendar.dateComponents([.day], from: date1, to: LastDayWeek)
                    let start: Int = CurrentToStart.day!
                    let end: Int = (CurrentToEnd.day!)+1
                    print("Start to  current\(start)")
                    print("Currrent to end\(end)")
                  var expensePerDay =  ExpenseValue/Double(start)
                  var weekExpense = expensePerDay * 7
                   var moneyWillLeft = WeekBudget - weekExpense
               print(expensePerDay)
                    var text = "Your average daily spend in this week is $\(expensePerDay)"
                    
                    descriptionLabel.text = text
                    print(weekExpense)
                    print(moneyWillLeft)

                    if moneyWillLeft > 0.0{

                    setBarChart(saved: moneyWillLeft, range: WeekGoal, color: NSUIColor.blue)
                               print("KKKKKKKKKK")
                         barChartView.notifyDataSetChanged()
                    } else {

                        setBarChart(saved: abs(moneyWillLeft), range: WeekGoal, color: NSUIColor.red)
                            print("KKSASSSSS")
                         barChartView.notifyDataSetChanged()
                    }
                }else if timeTag == 3{

                    let FirstDayMonth = Date().startOfMonth()
                    let LastDayMonth = Date().endOfMonth()

                    let CurrentToStart = calendar.dateComponents([.day], from: FirstDayMonth, to:date1)
                    let CurrentToEnd = calendar.dateComponents([.day], from: date1, to: LastDayMonth)
                    let start: Int = CurrentToStart.day!
                    let end: Int = (CurrentToEnd.day!)+1
                    print("Start to  current\(start)")
                    print("Currrent to end\(end)")


                    //Geting How many days in this Month
                    let MonthDay = calendar.dateComponents([.day], from: FirstDayMonth, to: LastDayMonth)
                    print("There are\(MonthDay.day!) in this Month!")
                    let monthDay: Double = Double(MonthDay.day!)

                    var expensePerDay =  ExpenseValue/Double(start)
                    var weekExpense = expensePerDay * Double(monthDay)
                    var moneyWillLeft = WeekBudget - weekExpense
                    print(expensePerDay)
                    print(weekExpense)
                    print(moneyWillLeft)
                    var text = "Your average daily spend in this month is $\(expensePerDay)"
                    
                    descriptionLabel.text = text
                    if moneyWillLeft > 0{
                        setBarChart(saved: moneyWillLeft, range: WeekGoal, color: NSUIColor.blue)
                         barChartView.notifyDataSetChanged()
                    } else{

                        setBarChart(saved: abs(moneyWillLeft), range: WeekGoal, color: NSUIColor.red)
                         barChartView.notifyDataSetChanged()
                    }
                    
                    
                }
                  barChartView.notifyDataSetChanged()




        }

        }

        
        //        print(listIncome)
//        print(listExpense)
//        print(IncomeType)
//        print(ExpenseType)
//        print(IncomeAmount)
//        print(ExpenseAmount)
//        print(IncomeTime)
//        print(ExpenseTime)
//        print("Time tag \(timeTag)")
//        print(IncomeShow)
//        print(ExpenseShow)
    }
    
    func TotalGet(){
        
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
        performSegue(withIdentifier: "segue3", sender: self)
    }
    
    @IBAction func SelectSort(_ sender: Any) {
            performSegue(withIdentifier: "segue5", sender: self)
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


