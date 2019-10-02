//
//  Routines.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/09/15.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import Foundation

class Routines :Codable{
    var title:String
    var doneToday:Bool
    var coutinuousRecord:Int
    
    init(title:String, doneToday:Bool,coutinuousRecord:Int) {
        self.title = title
        self.doneToday = doneToday
        self.coutinuousRecord = coutinuousRecord
    }
}
