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
    
    var list: [String]! = []
    var listIncome: [String]! = []
    var listExpense: [String]! = []
    
    //let listEx:[String]! = ["1","2","3","4","5"]
    
    var InOrExList:[Int] = [1,2,3]
    
    var TypeList:[Int] = []
    var IncomeType:[Int] = []
    var ExpenseType:[Int] = []
    
    var TimeList:[Date] = []
    var IncomeTime:[Date] = []
    var ExpenseTime:[Date] = []
    
    var AmountList:[Double] = []
    var IncomeAmount:[Double] = []
    var ExpenseAmount:[Double] = []
    
    
    
    var sections = [Section(genre: "Income", movies: [], expanded: false, type: [], amount: [], time: []),
                    Section(genre: "Expense", movies: [], expanded: false, type: [], amount: [], time: [])]
    
    
    
    
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
        //Need to be fit
        if tableView.tag == 0{
            // return(list.count)
            print(list)
            listCount = list.count
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
        if sections[indexPath.section].expanded == true{
            return 48
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
            cell.CellType.text = String(sections[indexPath.section].type[indexPath.row])
            cell.Amount.text = String(sections[indexPath.section].amount[indexPath.row])
            //format
            let dateFormat = DateFormatter()
             dateFormat.locale = Locale(identifier: "en_GB")
           dateFormat.setLocalizedDateFormatFromTemplate("MMMd")
            //dateFormat.dateStyle = .short
            //dateFormat.timeStyle = .short

            if (sections[indexPath.section].time[indexPath.row] as Date?) != nil   {
                
                cell.Time.text = dateFormat.string(from: sections[indexPath.section].time[indexPath.row])
            }
            
            print(sections[0].type)
            //  cell.CellType.text = sections[indexPath.section].type[indexPath.row]
            // var a = sections[indexPath.section].type[indexPath.row]
            //print(a)
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
    
    override func viewDidAppear(_ animated: Bool) {
        list = []
        InOrExList = []
        TypeList = []
        AmountList = []
        TimeList = []
        listIncome  = []
        
        
        IncomeType = []
        IncomeAmount = []
        IncomeTime = []
    listExpense = []
        ExpenseType = []
    ExpenseAmount = []
    ExpenseTime = []
        //Put all local storage to local variable
    
        let AddObject = UserDefaults.standard.object(forKey: "Add")
        if (AddObject as? [String]) != nil{
            list = AddObject as! [String]
            print(AddObject ?? 0)
        }
        
        let IncomeOrExpense = UserDefaults.standard.object(forKey: "IncomeOrExpense")
        if (IncomeOrExpense as? [Int]) != nil{
            InOrExList = IncomeOrExpense as! [Int]
            print(IncomeOrExpense ?? 0)
        }
        
        let InputType = UserDefaults.standard.object(forKey: "InputType")
        if (InputType as? [Int]) != nil{
            TypeList = InputType as! [Int]
            print(InputType ?? 0)
        }
        
        let amountObject = UserDefaults.standard.object(forKey: "Amount")
        if (amountObject as? [Double]) != nil{
            AmountList = amountObject as! [Double]
            print(amountObject ?? 0)
        }
        
        let dateObject = UserDefaults.standard.object(forKey: "time")
        if (dateObject as? [Date]) != nil{
            TimeList = dateObject as! [Date]
            print(TimeList )
        }
        
        
        if(list.count != 0){
            for  var i in (0..<list.count).reversed() {
                if(InOrExList[i] == 0){
                    listIncome.append(list[i])
                    IncomeType.append(TypeList[i])
                    IncomeAmount.append(AmountList[i])
                    IncomeTime.append(TimeList[i])
                }else{
                    listExpense.append(list[i])
                    ExpenseType.append(TypeList[i])
                    ExpenseAmount.append(AmountList[i])
                    ExpenseTime.append(TimeList[i])
                }
            }
        }
        sections[0].movies = listIncome
        sections[1].movies = listExpense
        sections[0].type = IncomeType
        sections[1].type = ExpenseType
        sections[0].amount = IncomeAmount
        sections[1].amount = ExpenseAmount
        sections[0].time = IncomeTime
        sections[1].time = ExpenseTime
        
        self.IncomeTable.reloadData()
        print(listIncome)
        print(listExpense)
        print(IncomeType)
        print(ExpenseType)
        print(IncomeAmount)
        print(ExpenseAmount)
        print(IncomeTime)
        print(ExpenseTime)
        
        //        let amountObject = UserDefaults.standard.object(forKey: "Amount")
        //        if (amountObject as? [Double]) != nil{
        //            amountOfCell = amountObject as! [Double]
        //            print(amountObject ?? 0)
        //        }
        
        
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
