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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

