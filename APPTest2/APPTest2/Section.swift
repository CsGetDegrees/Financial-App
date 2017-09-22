//
//  Section.swift
//  Budgetable1.2
//
//  Created by Tengzhe Li on 15/09/17.
//  Copyright © 2017 Tengzhe Li. All rights reserved.
//

import Foundation

struct Section {
    var genre: String!
    var movies: [String]!
    var expanded: Bool!
    
    init(genre: String, movies:[String], expanded: Bool) {
        self.genre = genre
        self.movies = movies
        self.expanded = expanded
    }
}
