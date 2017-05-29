//
//  ViewController.swift
//  APPTest2
//
//  Created by Tengzhe Li on 4/22/17.
//  Copyright © 2017 Tengzhe Li. All rights reserved.
//

import UIKit

var Goal:Double = 0.0
var Have:Double = 0.0


class ViewController: UIViewController {


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

   
//    @IBAction func pushMe(_ sender: Any) {
//        
//        let randomNumber = getGaussian()
//        print("result is \(randomNumber)")
//        RandomNum.text = "\(randomNumber)"
//    }

}

