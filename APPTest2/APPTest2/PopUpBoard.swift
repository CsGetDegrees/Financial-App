//
//  PopUpBoard.swift
//  APPTest2
//
//  Created by Tengzhe Li on 4/25/17.
//  Copyright © 2017 Tengzhe Li. All rights reserved.
//

import UIKit

class PopUpBoard: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blue.withAlphaComponent(0.7)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func BackToMain(_ sender: Any) {
        self.view.removeFromSuperview()
    }
    
  
}

