//
//  ViewController.swift
//  APPTest2
//
//  Created by Tengzhe Li on 4/22/17.
//  Copyright © 2017 Tengzhe Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


   @IBOutlet weak var RandomNum: UITextField!
   @IBOutlet weak var RandomNum1: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBAction func saveGoal(_ sender: Any) {
        //add cpp function here
       // let newGoal = SavingGoal(1.1, 2, 10, 5)
        
      //  var a = newGoal.getFrequency()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.layer.cornerRadius = 6
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

   
    @IBAction func pushMe(_ sender: Any) {
        
        let randomNumber = getGaussian()
        print("result is \(randomNumber)")
        RandomNum.text = "\(randomNumber)"
    }

}

