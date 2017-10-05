//
//  ViewController.swift
//  APPTest2
//
//  Created by Tengzhe Li on 4/22/17.
//  Copyright © 2017 Tengzhe Li. All rights reserved.
//

import UIKit
import Charts  // A third party library for charts generation.
var Goal:Double = 0.0
var Have:Double = 0.0


class ViewController: UIViewController {

    @IBOutlet weak var barChartView: BarChartView!
    
   @IBOutlet weak var RandomNum: UITextField!
   @IBOutlet weak var RandomNum1: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var BudgetGoal: UITextField!
    
    @IBOutlet weak var MoneyYouHold: UITextField!
    
    
    @IBAction func CheckDouble(_ sender: Any) {
        
        let checkGoal = Double(BudgetGoal.text!)
        let checkhold = Double(MoneyYouHold.text!)
        if(checkGoal != nil  && checkhold != nil){
            print("good Goal")
            saveButton.isUserInteractionEnabled = true
        }else{
            saveButton.isUserInteractionEnabled = false
                print("bad Goal")
        }
    }
    
    @IBAction func resitGoal(_ sender: Any) {
        Goal = 0.0
        Have = 0.0
        BudgetGoal.text = String(Goal)
        MoneyYouHold.text = String(Have)

    }
    
    @IBAction func saveGoal(_ sender: Any) {
        //Key and persistent data
        _ = UserDefaults.standard.object(forKey: "Goal")
        var goal:Double
        goal = Double(BudgetGoal.text!)!
        print("Goal\(goal)")
     UserDefaults.standard.set(goal,forKey: "Goal")
       
        _ = UserDefaults.standard.object(forKey: "Hold")
        var hold:Double
        hold = Double(MoneyYouHold.text!)!
        print("Have\(hold)")
        UserDefaults.standard.set(hold,forKey: "Hold")

    }
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBarChart(saved:5, range:10)
       let goalObject = UserDefaults.standard.object(forKey: "Goal")
        if (goalObject as? Double) != nil{
         Goal = goalObject as! Double
        }
        
        let holdObject = UserDefaults.standard.object(forKey: "Hold")
        if (holdObject as? Double) != nil{
            Have = holdObject as! Double
        }

        BudgetGoal.text = String(Goal)
        MoneyYouHold.text = String(Have)
        
       
    
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func setBarChart(saved: Double, range: Double){
        
        
        
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
        
        
        
        setDataCount(saved: saved, range:range)
        
        
        
    }
    
    
    
    func setDataCount( saved: Double, range: Double){
        
        
        
        let barWidth = 9.0
        
        let spaceForBar =  10.0;
        
        
        
        var yVals = [BarChartDataEntry]()
        
        
        
        
        
        
        
        yVals.append(BarChartDataEntry(x: Double(0) * spaceForBar, y: saved))
        
        
        
        yVals.append(BarChartDataEntry(x: Double(1) * spaceForBar, y: range))
        
        
        
        
        
        var set1 : BarChartDataSet!
        
        
        
        
        
        if let count = barChartView.data?.dataSetCount, count > 0{
            
            set1 = barChartView.data?.dataSets[0] as! BarChartDataSet
            
            set1.values = yVals
            
            
            
            barChartView.chartDescription?.text = ""
            
            barChartView.data?.notifyDataChanged()
            
            barChartView.notifyDataSetChanged()
            
            
            
            
            
        }else{
            
            set1 = BarChartDataSet(values: yVals, label: "")
            
            
            
           // colors of bars
            set1.colors=[NSUIColor.blue,NSUIColor.white]
            
            var dataSets = [BarChartDataSet]()
            
            dataSets.append(set1)
            
            
            
            let data = BarChartData(dataSets: dataSets)
            
            data.setDrawValues(false)
            
            
            
            data.barWidth =  barWidth;
            
            
            
            barChartView.data = data
            
            barChartView.isUserInteractionEnabled = false;
            
            barChartView.animate(yAxisDuration: 1.5, easingOption: .easeInOutQuart)
            
        }
        
        
        
        
        
        
        
    }
//    @IBAction func pushMe(_ sender: Any) {
//        
//        let randomNumber = getGaussian()
//        print("result is \(randomNumber)")
//        RandomNum.text = "\(randomNumber)"
//    }

}

