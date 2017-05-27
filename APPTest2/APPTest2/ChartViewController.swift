//
//  SecondViewController.swift
//  APPTest2
//
//  Created by Tengzhe Li on 4/25/17.
//  Copyright © 2017 Tengzhe Li. All rights reserved.
//


import UIKit
import Charts

class ChartViewController:  UIViewController{

    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var pieChartView: PieChartView!
    var months: [String]!

    func setPieChart(dataPoints: [String], values: [Double]) {
        pieChartView.noDataText = "You need to provide data for the chart."

        var dataEntries: [PieChartDataEntry] = []

        for i in 0..<dataPoints.count {
            let dataEntry=PieChartDataEntry(value: values[i], label: dataPoints[i])
            print(dataEntry)
            dataEntries.append(dataEntry)
        }


        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "Type")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartView.data = pieChartData
        pieChartDataSet.drawIconsEnabled = false;

        pieChartDataSet.sliceSpace = 2.0;
        pieChartDataSet.iconsOffset = CGPoint(x:0, y:40);
        var colors: [NSUIColor] = ChartColorTemplates.vordiplom()
        let colorsMore: [NSUIColor] = ChartColorTemplates.joyful()

        colors.append(contentsOf: colorsMore)
        pieChartDataSet.colors = colors
        pieChartView.drawEntryLabelsEnabled=true
        pieChartView.animate(xAxisDuration: 1.4)
        pieChartView.spin(duration: 2.0, fromAngle: pieChartView.rotationAngle, toAngle: pieChartView.rotationAngle + 360.0)
    }
    func setLineChart(dataPoints: [String], values: [Double]) {
        lineChartView.noDataText = "You need to provide data for the chart."

        var dataEntries: [ChartDataEntry] = []

        for i in 0..<dataPoints.count {
            let dataEntry=ChartDataEntry(x: Double(i), y: values[i], data: dataPoints[i] as AnyObject?)
            print(dataEntry)
            dataEntries.append(dataEntry)
        }

        var colors: [NSUIColor] = ChartColorTemplates.vordiplom()
        let colorsMore: [NSUIColor] = ChartColorTemplates.joyful()

        colors.append(contentsOf: colorsMore)
        let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "Type")
lineChartDataSet.setColor(colors[0])



        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        lineChartView.data = lineChartData

        lineChartView.dragEnabled = true
        lineChartView.setScaleEnabled(true)
        lineChartView.pinchZoomEnabled = false;
        lineChartView.drawGridBackgroundEnabled = false;
        lineChartView.maxHighlightDistance = 300.0;

        lineChartView.xAxis.enabled = false;


}

    override func viewDidLoad() {
        super.viewDidLoad()
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
        let moneySpent = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0]
        setPieChart(dataPoints: months, values: moneySpent)
        setLineChart(dataPoints: months, values: moneySpent)
        pieChartView.notifyDataSetChanged()

    }
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

