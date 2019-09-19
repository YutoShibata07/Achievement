//
//  User.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/09/15.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import Foundation
struct Data {
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
class UserData:NSObject{
    var data = Data(isFirstVisit: true)
    static let sharedData :UserData = UserData()
    private override init(){}
    
    func countDoneTask(){//既に達成したタスクの数を計算する。
        for task in routines{
            if task.doneToday == true{
                 data.doneCount += 1
            }
        }
        print(data.doneCount)
        print("OK")
//        data.recentCount[2] = data.doneCount//recentCountの中の今日の分のデータを更新する。
    }

    
    
}
