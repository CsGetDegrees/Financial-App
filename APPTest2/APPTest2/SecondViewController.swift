//
//  SecondViewController.swift
//  APPTest2
//
//  Created by Tengzhe Li on 4/25/17.
//  Copyright © 2017 Tengzhe Li. All rights reserved.
//


import UIKit
/* Name of list cell*/
var list = ["Saber", "Archer", "Caster","Assassin","Teacher","WallBuilder"]

/* The detail of list cell*/
var introduction = ["Artoria Pendragon", "Gilgamesh","Gilles de Rais","","","Donald J Trump"]

var myIndex = 0

class SecondViewController:  UIViewController, UITableViewDelegate,UITableViewDataSource{
    
  
    @IBOutlet weak var myTableView: UITableView!
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(list.count)
    }
    
    public   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = self.myTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)as!CustomCell
        
        //cell.textLabel?.text = list[indexPath.row]
        cell.time.text = list[indexPath.row]
        cell.name.text = introduction[indexPath.row]
        
        cell.time.textColor = UIColor.white
        cell.name.textColor = UIColor.yellow
        
        if(indexPath.row)%2 != 0{
        cell.backgroundColor=UIColor.darkGray
        }else{
        cell.backgroundColor=UIColor.black
        }
      
        return(cell)
    }
    
   func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == editingStyle{
         list.remove(at: indexPath.row)
            myTableView.reloadData()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        myTableView.reloadData()
        print("\(list[myIndex])")
        
        
    }    
 func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        myIndex = indexPath.row
        performSegue(withIdentifier: "segue", sender: self)
    }
}
