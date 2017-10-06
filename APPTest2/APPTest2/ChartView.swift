//
//  SecondViewController.swift
//  This classs is using a 3rd party free library on Github.
//  The Github link of the library is: https://github.com/danielgindi/Charts
//  The #1 contributor of the library is: danielgindi.
//
//  Created by Huiyu Jia on 5/27/17.
//  Copyright © 2017 TopCatAppDevelopment. All rights reserved.
//


import UIKit
import Charts  // A third party library for charts generation.

class ChartView:  UIViewController{
    
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var pieChartView: PieChartView!
    
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
    
    var DateArrayCell: [sectionCell] = []
    var DateIncomeCell:[sectionCell] = []
    var DateExpenseCell:[sectionCell] = []
    
    var tableShow: [Int] = []
    var timeTag: Int = 0
    
    var months: [Date]!
    let type = ["Food", "Family", "Gas&Fuel", "CashFlow", "Pc", "Beer","6","7","else"]
    let moneySpent:[Double] = MoneySpent
    /**
     *This function will generate and update the pie chart view.
     *@params dataPoints contains labels of for the data.
     *@params values the numbers that'll be calculated and displayed.
     */
    func setPieChart(dataPoints: [String], values: [Double]) {
        // this data will be loaded on the view when user have no data entries
        
        
        pieChartView.noDataText = "You need to provide data for the chart."
        
        var dataEntries: [PieChartDataEntry] = []
        
        for i in 0..<dataPoints.count { // use a loop to entry data in the array
            if( values[i]>0){
                let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i])
                dataEntries.append(dataEntry)
            }
        }
        
        // give the data entries a label and put it inthe data set
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartView.data = pieChartData // set the pie chart data
        pieChartDataSet.drawIconsEnabled = true;
        pieChartView.legend.drawInside = true;
        
        pieChartView.drawEntryLabelsEnabled=false // dont show lable inside the pie chart
        
        pieChartView.legend.xEntrySpace = 8.0;
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = Locale.current
        let valuesNumberFormatter = ChartValueFormatter(numberFormatter: numberFormatter)
        numberFormatter.numberStyle = .percent
        pieChartDataSet.valueFormatter = valuesNumberFormatter
        
        // poly line
        pieChartDataSet.valueLinePart1OffsetPercentage = 0.8;
        pieChartDataSet.valueLinePart1Length = 0.2;
        pieChartDataSet.valueLinePart2Length = 0.4;
        pieChartDataSet.entryLabelColor = UIColor.black;
        pieChartDataSet.valueTextColor = UIColor.black;
        pieChartDataSet.yValuePosition = PieChartDataSet.ValuePosition(rawValue: ValuePosition.outsideSlice.rawValue)!;
        
        
        pieChartDataSet.sliceSpace = 2.0; // the space between areas
        pieChartDataSet.iconsOffset = CGPoint(x:0, y:40);
        var colors: [NSUIColor] = ChartColorTemplates.vordiplom()
        let colorsMore: [NSUIColor] = ChartColorTemplates.joyful() // built in great colors
        
        //legend
        pieChartView.legend.orientation = Legend.Orientation.vertical
        pieChartView.legend.font = UIFont(name: "Verdana", size: 14.0)!
        
        colors.append(contentsOf: colorsMore)
        pieChartDataSet.colors = colors // set the color array for the pie chart
        
        // description
        pieChartView.chartDescription?.text = "Category-wise Spending"
        pieChartView.chartDescription?.font = UIFont(name: "Verdana", size: 14.0)!
        
        pieChartView.animate(xAxisDuration: 1.4)
        pieChartView.spin(duration: 2.0, fromAngle: pieChartView.rotationAngle, toAngle: pieChartView.rotationAngle + 360.0)
    }
    
    
    /**
     *This function will generate and update the line chart view.
     *@params dataPoints contains labels of for the data.
     *@params values the numbers that'll be calculated and displayed.
     */
    func setLineChart(dataPoints: [Date], values: [Double]) {
        lineChartView.noDataText = "You need to provide data for the chart."
        // this data will be loaded on the view when user have no data entries
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {// use a loop to entry data in the array
            let dataEntry=ChartDataEntry(x: Double(i), y: values[i])
            //, data: dataPoints[i] as AnyObject?
            dataEntries.append(dataEntry)
        }
        // give the data entries a label and put it inthe data set
        var colors: [NSUIColor] = ChartColorTemplates.vordiplom()
        let colorsMore: [NSUIColor] = ChartColorTemplates.joyful()
        
        colors.append(contentsOf: colorsMore)// set the color array for the pie chart
        
        let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "Total")
        lineChartDataSet.setColor(colors[0])
        
        lineChartDataSet.axisDependency = .left
        
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        lineChartView.data = lineChartData
        
        // Axis
        let xAxis = lineChartView.xAxis
        
        xAxis.labelPosition = .bottom
        xAxis.labelCount = dataEntries.count
        xAxis.drawLabelsEnabled = true
        xAxis.drawLimitLinesBehindDataEnabled = true
        xAxis.avoidFirstLastClippingEnabled = true
        
        
        // date formatter
        //let xValuesNumberFormatter = ChartXAxisFormatter()
        //let df = DateFormatter()
        //df.locale = Locale(identifier: "en_GB")
        //df.setLocalizedDateFormatFromTemplate("MMMd")
        //xValuesNumberFormatter.dateFormatter = df // e.g. "wed 26"
        //xAxis.valueFormatter = xValuesNumberFormatter
        
        lineChartView.dragEnabled = true
        lineChartView.setScaleEnabled(false)
        lineChartView.pinchZoomEnabled = false; // no zoom!
        lineChartView.drawGridBackgroundEnabled = false;
        lineChartView.maxHighlightDistance = 300.0;
        
        lineChartView.xAxis.enabled = false;
        lineChartView.animate(xAxisDuration: 1.2)// draw from left to right
        
        //description
        lineChartView.chartDescription?.text = "Daily spending over a week"
        lineChartView.chartDescription?.font = UIFont(name: "Verdana", size: 14.0)!
        
    }
    
    //Need to be fit
    func TimeRange(){
        print("Second View Time range")
        //   let todayDate = Date()
        let calendar = NSCalendar.current
        //  let date1 = calendar.startOfDay(for: todayDate)
        
        
        if(timeTag == 2){
            let FirstDayWeek = Date().startOfWeek()
            
            //Comparing Date List element with current Date
            for  t in TimeList{
                let ToStart = calendar.dateComponents([.day], from: FirstDayWeek, to: t)
                
                if(ToStart.day! <= 7 && ToStart.day! >= 0){
                    tableShow.append(0)
                }else{
                    tableShow.append(1)
                }
            }
        }else if(timeTag == 1){
            let Today = Date()
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
            let LastDayMonth = Date().endOfMonth()
            
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
        }else if (timeTag == 0){
            for  _ in TimeList{
                tableShow.append(0)
                
            }
        }
        
        print(tableShow)
    }
    
    func transforDate(date:Date) -> Int {
       let calendar = NSCalendar.current
        if(timeTag == 2){
            let FirstDayWeek = Date().startOfWeek()
            //let date1 = calendar.startOfDay(for: Date())
            let CurrentToStart = calendar.dateComponents([.day], from: FirstDayWeek, to:date)
            let dayweek: Int = CurrentToStart.day!
            print(dayweek)
            return dayweek
        }else{
            let FirstDayMonth = Date().startOfMonth()
           // let LastDayMonth = Date().endOfMonth()
            
            let CurrentToStart = calendar.dateComponents([.day], from: FirstDayMonth, to:date)
          
           // let start: Int = CurrentToStart.day!
            let dayMonth: Int = CurrentToStart.day!
            print(dayMonth)
            return dayMonth
            
            //Geting How many days in this Month
           // let MonthDay = calendar.dateComponents([.day], from: FirstDayMonth, to: LastDayMonth)
           // print("There are\(MonthDay.day!) in this Month!")
            
        }
       // return 0
    }
    
    func localstorage(){
        
        list = []
        InOrExList = []
        TypeList = []
        AmountList = []
        TimeList = []
        
        tableShow = []
        
        ArrayCell = []
        DateArrayCell = []
        DateIncomeCell = []
        DateExpenseCell = []
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
        
        let UUIDObject = UserDefaults.standard.object(forKey: "UniqueID")
        if (UUIDObject as? [String]) != nil{
            notificationID = UUIDObject as! [String]
            print(UUIDObject ?? 0)
        }
       
        TimeRange()
       
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
        
        
        DateArrayCell = ArrayCell
        
        if timeTag != 1 && timeTag != 0{
        if DateArrayCell.count > 0{
            for i in 0..<DateArrayCell.count{
                let a  = transforDate(date: DateArrayCell[i].dateInput)
          // print("first\(a)")
                for j in 0..<DateArrayCell.count{
                    let b  = transforDate(date: DateArrayCell[j].dateInput)
                 //  print("second\(b)")
                    if a == b && DateArrayCell[i].notificationID != DateArrayCell[j].notificationID && DateArrayCell[i].tableShow != 1 && DateArrayCell[i].typeOfAmount == DateArrayCell[j].typeOfAmount{
                        //Unique ID
                        DateArrayCell[i].amountOfCell += DateArrayCell[j].amountOfCell
                        DateArrayCell[i].dateInput = DateArrayCell[j].dateInput
                        // ArrayCell[i].notificationID = ArrayCell[j].notificationID
                        DateArrayCell[j].tableShow = 1
                        DateArrayCell[i].list += DateArrayCell[j].list
                        
                    }
                }
            }
            
        }
        for i in 0..<DateArrayCell.count{
            if DateArrayCell[i].tableShow != 1{
            print(DateArrayCell[i].dateInput)
            }
        }
        
            for i in 0..<DateArrayCell.count{
                if DateArrayCell[i].tableShow != 1{
                    if(DateArrayCell[i].typeOfAmount == 0){
                        DateIncomeCell.append(DateArrayCell[i])
                    }else{
                        DateExpenseCell.append(DateArrayCell[i])
                    }
                }
            }
            
            for i in 0..<DateIncomeCell.count{
                print("InDate")
                print(dateFormat.string(from: DateIncomeCell[i].dateInput))
            }
            for i in 0..<DateExpenseCell.count{
                print("ExDate")
                print(dateFormat.string(from: DateExpenseCell[i].dateInput))
            }
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
        
        for i in 0..<IncomeCell.count{
            print("In")
            print(dateFormat.string(from: IncomeCell[i].dateInput))
        }
        for i in 0..<ExpenseCell.count{
            print("Ex")
            print(dateFormat.string(from: ExpenseCell[i].dateInput))
        }
        
    }
    

    
    

    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        localstorage()
        
        var CatEx: [String]! = ["Bills","Transport","Clothes","EatingOut","Entertainment","Health","Food","Pet","House","Else"]
        var CatIn: [String]! = ["Deposits","Salary","Saving"]
        
        var CatShow: [String]! = []
        var AmountNum: [Double]! = []
        
        for i in 0..<IncomeCell.count{
            CatShow.append(String(CatIn[IncomeCell[i].typeOfCell]))
            AmountNum.append(IncomeCell[i].amountOfCell)
        }
      
        var total = 0.0;
        for i in 0..<AmountNum.count {
            total += AmountNum[i]
        }
        for i in 0..<AmountNum.count{
            AmountNum[i] = AmountNum[i]/total
        }
        
          print(CatShow)
        setPieChart(dataPoints: CatShow , values: AmountNum)
        //        setLineChart(dataPoints: months, values: mock)
        pieChartView.notifyDataSetChanged() // to display the labels
        
        
        
        
//        let type = ["Food", "Family", "Gas&Fuel", "CashFlow", "Pc", "Beer","6","7","else"]
//        let mock = [120.0,120.0,120.0,120.0,120.0,20.0]
//        months = [generateRandomDate(daysBack: 7)!, generateRandomDate(daysBack: 7)!, generateRandomDate(daysBack: 7)!, generateRandomDate(daysBack: 7)!, generateRandomDate(daysBack: 7)!, generateRandomDate(daysBack: 7)!]
       
        var Amount: [Double] = [0.0, 0.0 , 0.0 , 0.0, 0.0, 0.0,0.0]
        let week: [Date] = [generateRandomDate(daysBack: 7)!, generateRandomDate(daysBack: 7)!, generateRandomDate(daysBack: 7)!, generateRandomDate(daysBack: 7)!, generateRandomDate(daysBack: 7)!, generateRandomDate(daysBack: 7)!, generateRandomDate(daysBack: 7)!]
     
        for i in 0..<DateIncomeCell.count {
              Amount[transforDate(date: DateIncomeCell[i].dateInput)] = DateIncomeCell[i].amountOfCell
        }
       setLineChart(dataPoints: week, values: Amount)
        
//        var moneySpent:[Double] = MoneySpent
//        print(moneySpent)
//        var total = 0.0;
//        for i in 0..<moneySpent.count {
//            total += moneySpent[i]
//        }
//        for i in 0..<moneySpent.count {
//            moneySpent[i] = moneySpent[i]/total
//        }
//        setPieChart(dataPoints: type , values: moneySpent)
       
//        pieChartView.notifyDataSetChanged() // to display the labels
    }
    
    func generateRandomDate(daysBack: Int)-> Date?{
        let day = arc4random_uniform(UInt32(daysBack))+1
        let hour = arc4random_uniform(23)
        let minute = arc4random_uniform(59)
        
        let today = Date(timeIntervalSinceNow: 0)
        let gregorian  = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        var offsetComponents = DateComponents()
        offsetComponents.day = Int(day - 1)
        offsetComponents.hour = Int(hour)
        offsetComponents.minute = Int(minute)
        
        let randomDate = gregorian?.date(byAdding: offsetComponents, to: today, options: .init(rawValue: 0) )
        return randomDate
    }
    /**
     * I'm not sure if I'm using this formatter or not but I decided not to fix
     what's not broken.
     *
     */
    @objc(BarChartFormatter)
    public class BarChartFormatter: NSObject, IAxisValueFormatter
    {
        var names = [String]()
        
        public func stringForValue(_ value: Double, axis: AxisBase?) -> String
        {
            return names[Int(value)]
        }
        
        public func setValues(values: [String])
        {
            self.names = values
        }
    }
    
    /**
     * It's the double to percentage formatter.
     */
    class ChartValueFormatter: NSObject, IValueFormatter {
        fileprivate var numberFormatter: NumberFormatter?
        
        convenience init(numberFormatter: NumberFormatter) {
            self.init()
            self.numberFormatter = numberFormatter
        }
        
        func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
            guard let numberFormatter = numberFormatter
                else {
                    return ""
            }
            return numberFormatter.string(for: value)!
        }
    }
    @IBAction func TimeRange(_ sender: Any) {
     performSegue(withIdentifier: "segue", sender: self)
    
    
    }
    
}
