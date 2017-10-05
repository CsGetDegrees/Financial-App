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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        //////test mock data
        months = [generateRandomDate(daysBack: 7)!, generateRandomDate(daysBack: 7)!, generateRandomDate(daysBack: 7)!, generateRandomDate(daysBack: 7)!, generateRandomDate(daysBack: 7)!, generateRandomDate(daysBack: 7)!]
        let mock = [120.0,120.0,120.0,120.0,120.0,20.0]
        let type = ["Food", "Family", "Gas&Fuel", "CashFlow", "Pc", "Beer","6","7","else"]
        var moneySpent:[Double] = MoneySpent
        var total = 0.0;
        for i in 0..<moneySpent.count {
            total += moneySpent[i]
        }
        for i in 0..<moneySpent.count {
            moneySpent[i] = moneySpent[i]/total
        }
        setPieChart(dataPoints: type , values: moneySpent)
        setLineChart(dataPoints: months, values: mock)
        pieChartView.notifyDataSetChanged() // to display the labels
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let type = ["Food", "Family", "Gas&Fuel", "CashFlow", "Pc", "Beer","6","7","else"]
        let mock = [120.0,120.0,120.0,120.0,120.0,20.0]
        months = [generateRandomDate(daysBack: 7)!, generateRandomDate(daysBack: 7)!, generateRandomDate(daysBack: 7)!, generateRandomDate(daysBack: 7)!, generateRandomDate(daysBack: 7)!, generateRandomDate(daysBack: 7)!]
        var moneySpent:[Double] = MoneySpent
        print(moneySpent)
        var total = 0.0;
        for i in 0..<moneySpent.count {
            total += moneySpent[i]
        }
        for i in 0..<moneySpent.count {
            moneySpent[i] = moneySpent[i]/total
        }
        setPieChart(dataPoints: type , values: moneySpent)
        setLineChart(dataPoints: months, values: mock)
        pieChartView.notifyDataSetChanged() // to display the labels
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
