//
//  InputType.swift
//  Budgetable
//
//  Created by Tengzhe Li on 22/09/17.
//  Copyright © 2017 Tengzhe Li. All rights reserved.
//



import Foundation
import UIKit


class InputType: UIViewController , UITableViewDelegate, UITableViewDataSource{
    

    @IBOutlet weak var TypeTable: UITableView!
    
    let list: [String]! = ["a","b","b","c"]
    let listEx:[String]! = ["1","2","2"]
    
    var styleSwitch: Int = 0;
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count;
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let  cell = self.TypeTable.dequeueReusableCell(withIdentifier: "cellHeader", for: indexPath)as! HeaderViewCell
        cell.transform = CGAffineTransform(scaleX: 1, y: -1);
        // cell.Name.text = listIncome[indexPath.row]
        cell.Name.text = list[indexPath.row]
        return(cell)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.TypeTable.transform = CGAffineTransform(scaleX: 1, y: -1);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("2")
    }

}
