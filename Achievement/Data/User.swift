//
//  User.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/09/15.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import Foundation
import UIKit


struct User {
    var isFirstVisit:Bool
    var doneCount = 0
    var recentCount:[Int] = [0,0,0]
    
    init(isFirstVisit:Bool) {
        self.isFirstVisit = isFirstVisit
        doneCount = 0
        recentCount = [0,0,0]//過去三日間の達成したroutineの数
        
    }
}

//Userの一つしかないデータセットを扱うクラス
class UserData{
    var data = User(isFirstVisit: true)
    static let sharedData :UserData = UserData()
    var journalsToShow = [Journals]()
    var routinesToShow = [Routines]()
    
    var categoriesToShow = [Category.init(name: "読書", color: "レッド"),Category.init(name:"授業", color: "ブルー")]
    private init(){}
    
    func countDoneTask(){//既に達成したタスクの数を計算する。
        for task in routinesToShow{
            if task.doneToday == true{
                 data.doneCount += 1
            }
        }
//        data.recentCount[2] = data.doneCount//recentCountの中の今日の分のデータを更新する。
    }

    
    struct DefaultColors {
        var names = ["レッド","ブルー","イエロー","パーポｳ","ピンク","ブラック","ブラウン"]
        var colors:[UIColor]
            = [UIColor.red, UIColor.blue, UIColor.yellow,UIColor.purple,UIColor.systemPink,UIColor.black, UIColor.brown ]
    }
    
    
}
struct DefaultColors {
    var names = ["レッド","ブルー","イエロー","パーポｳ","ピンク","ブラック","ブラウン"]
//    var colors:[UIColor]
//        = [UIColor.red, UIColor.blue, UIColor.yellow,UIColor.purple,UIColor.systemPink,UIColor.black, UIColor.brown ]
}
