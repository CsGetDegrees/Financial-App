//
//  FirstViewController.swift
//  APPTest2
//
//  Created by Tengzhe Li on 4/25/17.
//  Copyright © 2017 Tengzhe Li. All rights reserved.
//


import UIKit

class FirstViewController: UIViewController{
   
    @IBOutlet weak var InputTextField: UITextField!
 
   
  
    
    @IBAction func AddText(_ sender: AnyObject) {
        if(InputTextField.text != ""){
        list.append(InputTextField.text!)
            InputTextField.text = ""
        }
    }
    

    

}
