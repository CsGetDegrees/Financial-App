//
//  ViewController.swift
//  APPTest2
//
//  Created by Tengzhe Li on 4/22/17.
//  Copyright © 2017 Tengzhe Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var LA: UILabel!
    @IBOutlet weak var IM: UIImageView!
    @IBOutlet weak var TX: UITextField!

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
    @IBAction func PopUpTest(_ sender: AnyObject) {
        let popOverVC = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "Pop")as!PopUpBoard
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
    }

    @IBAction func BackToMain(_ sender: Any) {
        //performSegue(withIdentifier: "LastToBegin", sender: self)
    }
}

