//
//  Section.swift
//  Budgetable1.2
//
//  Created by Tengzhe Li on 15/09/17.
//  Copyright © 2017 Tengzhe Li. All rights reserved.
//

import Foundation

struct sectionCell {
    var list:String
    var dateInput:Date
    var typeOfCell:Int
    var amountOfCell:Double
    var typeOfAmount: Int
    var tableShow: Int
    var notificationID: String
}



struct Section {
    
    
    var genre: String!
//    var movies: [String]!
    var expanded: Bool!
//    var type:[Int]!
//    var amount:[Double]!
//    var time:[Date]
//    var display:[Int]!
    var cell: [sectionCell]!
    
    init(genre: String, expanded: Bool, cell: [sectionCell]) {
        self.genre = genre
        self.expanded = expanded
        self.cell = cell
    }
    
//    init(genre: String, movies:[String], expanded: Bool, type:[Int], amount:[Double], time:[Date], display:[Int]) {
//        self.genre = genre
//        self.movies = movies
//        self.expanded = expanded
//        self.type = type
//        self.amount = amount
//        self.time = time
//        self.display = display
//     //   self.cell = cell
//    }
    
    
    
    
}
