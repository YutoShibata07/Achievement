//
//  Journals.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/09/15.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import Foundation
import UIKit

struct Journals :Codable{
    var title:String
    var isToday:Bool
    var categoryColor:String
    var categoryName:String
    //ジャーナルが属するカテゴリー。名前と色の二つの属性を持つ。
    
    init(title:String,isToday:Bool, categoryName:String, categorycolor:String) {
        self.title = title
        self.isToday = isToday
        self.categoryName = categoryName
        self.categoryColor = categorycolor
    }
}



struct Category:Codable{
    var name :String!
    var color:String!
    
    
    init(name:String, color:String) {
        self.name = name
        self.color = color
    }
}
