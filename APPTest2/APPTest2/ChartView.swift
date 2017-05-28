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
    var months: [String]!
    
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
            let dataEntry=PieChartDataEntry(value: values[i], label: dataPoints[i])
            print(dataEntry)
            dataEntries.append(dataEntry)
        }
        
        // give the data entries a label and put it inthe data set
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "Type")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartView.data = pieChartData // set the pie chart data
        pieChartDataSet.drawIconsEnabled = false;
        
        pieChartDataSet.sliceSpace = 2.0; // the space between areas
        pieChartDataSet.iconsOffset = CGPoint(x:0, y:40);
        var colors: [NSUIColor] = ChartColorTemplates.vordiplom()
        let colorsMore: [NSUIColor] = ChartColorTemplates.joyful() // built in great colors
        
        colors.append(contentsOf: colorsMore)
        pieChartDataSet.colors = colors // set the color array for the pie chart
        pieChartView.drawEntryLabelsEnabled=true
        pieChartView.animate(xAxisDuration: 1.4)
        pieChartView.spin(duration: 2.0, fromAngle: pieChartView.rotationAngle, toAngle: pieChartView.rotationAngle + 360.0)
    }
    
    
    /**
     *This function will generate and update the line chart view.
     *@params dataPoints contains labels of for the data.
     *@params values the numbers that'll be calculated and displayed.
     */
    func setLineChart(dataPoints: [String], values: [Double]) {
        lineChartView.noDataText = "You need to provide data for the chart."
        // this data will be loaded on the view when user have no data entries
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {// use a loop to entry data in the array
            let dataEntry=ChartDataEntry(x: Double(i), y: values[i], data: dataPoints[i] as AnyObject?)
            print(dataEntry)
            dataEntries.append(dataEntry)
        }
        // give the data entries a label and put it inthe data set
        var colors: [NSUIColor] = ChartColorTemplates.vordiplom()
        let colorsMore: [NSUIColor] = ChartColorTemplates.joyful()
        
        colors.append(contentsOf: colorsMore)// set the color array for the pie chart
        
        let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "Type")
        lineChartDataSet.setColor(colors[0])
        
        
        
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        lineChartView.data = lineChartData
        
        lineChartView.dragEnabled = true
        lineChartView.setScaleEnabled(true)
        lineChartView.pinchZoomEnabled = false; // no zoom!
        lineChartView.drawGridBackgroundEnabled = false;
        lineChartView.maxHighlightDistance = 300.0;
        
        lineChartView.xAxis.enabled = false;
        lineChartView.animate(xAxisDuration: 1.2)// draw from left to right
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //////test mock data
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
        let moneySpent = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0,20.0, 4.0, 6.0, 3.0, 12.0, 16.0]
        /////////
        let date = ["a", "b", "c", "d", "e", "f","a", "b", "c", "d", "e", "f"]
        setPieChart(dataPoints: date , values: moneySpent)
        setLineChart(dataPoints: date, values: moneySpent)
        pieChartView.notifyDataSetChanged() // to display the labels
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
    
    
}

