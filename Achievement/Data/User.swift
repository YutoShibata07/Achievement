//
//  User.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/09/15.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

//どう見ても使ってないデータばかり。後で消す
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
    var numberOfJournals = 0
    var journalsToShow = [Journal]()
    var journalsReversed = [Journal]()
    var notificationTime = Date()
    var categoriesToShow = [Category.init(name: "読書", color: "レッド"),Category(name: "ToDo", color: "ブルー"),Category(name:"分類なし", color: "グレー")]
    private init(){}
    

    
    struct DefaultColors { //初期状態のアプリに表示するデフォルトのカテゴリ。
        var names = ["レッド","ブルー","イエロー","パーポｳ","ピンク","ブラック","ブラウン","グレー","シアン","オレンジ"]
        var colors:[UIColor]
            = [UIColor.red, UIColor.blue, UIColor.yellow,UIColor.purple,UIColor.systemPink,UIColor.black, UIColor.brown, UIColor.gray , UIColor.cyan, UIColor.orange]
    }
}

class RealmUserData:Object{
    @objc dynamic var shared :RealmUserData = RealmUserData()
    @objc dynamic var numberOfJournals = 0
    dynamic var journalsToShow = List<RealmJournal>()
    dynamic var journalsReversed = List<RealmJournal>()
    @objc dynamic var notificationTaime = Date()
    @objc dynamic var defaultCategory = [RealmCategory(name: "読書", color:"レッド"),RealmCategory(name: "ToDo", color: "ブルー"),RealmCategory(name:"分類なし", color: "グレー")]
    
}


