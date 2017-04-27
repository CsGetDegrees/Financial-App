//
//  ViewController.swift
//  Bugetable
//
//  Created by Tengzhe Li on 4/27/17.
//  Copyright © 2017 Tengzhe Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var RandomNum: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func Push(_ sender: Any) {
        let randomNumber = getGaussian()
        print("result is \(randomNumber)")
        RandomNum.text = "\(randomNumber)"
    }
    @IBAction func MainToFirst(_ sender: Any) {
         performSegue(withIdentifier: "MainToFirst", sender: self)
    }
   
    @IBAction func FirstToMain(_ sender: Any) {
        performSegue(withIdentifier: "FirstToMain", sender: self)

    }
    @IBAction func MainToPop(_ sender: Any) {
        performSegue(withIdentifier: "MainToPop", sender: self)
    }
}

