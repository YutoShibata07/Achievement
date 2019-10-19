//
//  Journal.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/10/16.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import Foundation
import UIKit

class Journal :Codable{
    var title:String
    var isToday:Bool
    var categoryColor:String
    var categoryName:String
    var creationDate:String!//このJournalが作成された日にちを保持する。
    //ジャーナルが属するカテゴリー。名前と色の二つの属性を持つ。
    
    init(title:String,isToday:Bool, categoryName:String, categorycolor:String, creationDate:String) {
        self.title = title
        self.isToday = isToday
        self.categoryName = categoryName
        self.categoryColor = categorycolor
        self.creationDate = creationDate
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

