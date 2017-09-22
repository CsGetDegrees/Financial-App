//
//  TotalView.swift
//  Budgetable
//
//  Created by Tengzhe Li on 21/09/17.
//  Copyright © 2017 Tengzhe Li. All rights reserved.
//

import Foundation
import UIKit


class TotalView: UIViewController , UITableViewDelegate, UITableViewDataSource, ExpandableHeaderViewDelegate{
    
    @IBOutlet weak var AddButton: UIButton!
    
    let list: [String]! = ["a","b","b","c"]
    let listEx:[String]! = ["1","2","3","4","5"]
    
    var sections = [Section(genre: "Income", movies: ["Bank","Salery","Family"], expanded: false),
                    Section(genre: "Expense", movies: ["Food","Transport","Rent","Fine"], expanded: false)]
    
    let listIncome = ["100","200","300"]
    let listExpense = ["9","8","7","6","5","4"]
    
    
    // @IBOutlet weak var extraTable: UITableView!
    // @IBOutlet weak var TypeTable: UITableView!
    @IBOutlet weak var IncomeTable: UITableView!
    
    var listCount: Int = 0
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        if tableView.tag == 2{
            return sections.count
        }else{
            return 1
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(".")
        
        if tableView.tag == 0{
            // return(list.count)
            print(list)
            listCount = list.count
            return listCount
        }else if tableView.tag == 1{
            // return(listEx.count)
            print(listEx)
            listCount = listEx.count
            return listCount
        }else if tableView.tag == 2 {
            //Table with header
            return sections[section].movies.count
            // return(listIncome.count)
        }else{
            return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (sections[indexPath.section].expanded){
            return 44
        }else{
            return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandableHeaderView()
        header.customInit(title: sections[section].genre, section: section, delegate: self as ExpandableHeaderViewDelegate)
        return header
    }
    
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // print("FK!!!!")
        
        if tableView.tag == 2{
            let  cell = self.IncomeTable.dequeueReusableCell(withIdentifier: "cellHeader", for: indexPath)as! HeaderViewCell
            
            // cell.Name.text = listIncome[indexPath.row]
            cell.Name.text = sections[indexPath.section].movies[indexPath.row]
            return(cell)
            
            
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)as UITableViewCell
            
            return (cell)
        }
    }
    
    func toggleSection(header: ExpandableHeaderView, section: Int) {
        sections[section].expanded = !sections[section].expanded
        
        IncomeTable.beginUpdates()
        for i in 0 ..< sections[section].movies.count{
            IncomeTable.reloadRows(at: [IndexPath(row: i, section:section)], with: .automatic)
        }
        IncomeTable.endUpdates()
        
    }
    
    @IBAction func changeMovies(_ sender: Any) {
        sections[0].movies = list
        self.IncomeTable.reloadData()
        //self.viewWillAppear(true)
        self.viewDidLoad()
        // sections[1].expanded = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       AddButton.layer.zPosition = 101;
        print("11")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("2")
    }
    //Connect to CustomCell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        print(indexPath)
        
        //  performSegue(withIdentifier: "segue", sender: self)
}
    
    @IBAction func AddNew(_ sender: Any) {
        performSegue(withIdentifier: "segue", sender: self)

    }
    
}
