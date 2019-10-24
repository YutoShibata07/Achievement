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
    var journalsToShow = [Journal]()
    var journalsReversed = [Journal]()
    var categoriesToShow = [Category.init(name: "読書", color: "レッド"),Category(name: "ToDo", color: "ブルー"),Category.init(name:"分類なし", color: "グレー")]
    private init(){}
    

    
    struct DefaultColors { //初期状態のアプリに表示するデフォルトのカテゴリ。
        var names = ["レッド","ブルー","イエロー","パーポｳ","ピンク","ブラック","ブラウン","グレー"]
        var colors:[UIColor]
            = [UIColor.red, UIColor.blue, UIColor.yellow,UIColor.purple,UIColor.systemPink,UIColor.black, UIColor.brown, UIColor.gray ]
    }
    
    
}



