//
//  Journals.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/09/15.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import Foundation

struct Journals :Codable{
    var title:String!
    var isToday:Bool!
    var genre:String!
    var category:Category!
    
    init(title:String,isToday:Bool, genre:String) {
        self.title = title
        self.isToday = isToday
        self.genre = genre
    }
}

struct Category:Codable{
    let name:String!
}

