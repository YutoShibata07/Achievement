//
//  Journal.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/10/16.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift


class Journal :Codable{
    var title:String
    var isToday:Bool
    var categoryColor:String
    var categoryName:String
    var creationDate:String!//このJournalが作成された日にちを保持する。
    var detail:String?
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


class DateMixedJournal{
    var title:String!
    var isDate:Bool!
    
    init(title:String, isDate:Bool) {
        self.title = title
        self.isDate = isDate
    }
}

class RealmJournal:Object{
    @objc dynamic var title:String
    @objc dynamic var categoryColor:String
    @objc dynamic var categoryName:String
    @objc dynamic var creationDate:String!//このJournalが作成された日にちを保持する。
    @objc dynamic var detail:String?
    //ジャーナルが属するカテゴリー。名前と色の二つの属性を持つ。
    
    init(title:String, categoryName:String, categorycolor:String, creationDate:String) {
        self.title = title
        self.categoryName = categoryName
        self.categoryColor = categorycolor
        self.creationDate = creationDate
    }
    
    override required init() {
        fatalError("init() has not been implemented")
    }
}

class RealmCategory:Object{
     @objc dynamic var name :String!
     @objc dynamic var color:String!
       
    
    init(name:String, color:String) {
        self.name = name
        self.color = color
    }
    
    override required init() {
        fatalError("init() has not been implemented")
    }
}
