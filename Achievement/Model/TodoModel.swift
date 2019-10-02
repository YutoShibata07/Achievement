//
//  TodoModel.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/10/02.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import Foundation

class TodoModel{
    
    let ud = UserDefaults.standard
    var lastVisitTime:Date!
    var routines = UserData.sharedData.routinesToShow //名前が長すぎるので変数を作った。

    func loadRoutines() {
        guard let data = ud.data(forKey: "routinesToShow"),
            let loadedData = try? JSONDecoder().decode([Routines].self, from: data) else {return}
        
        UserData.sharedData.routinesToShow = loadedData
        return
    }
    func resetData(){//今日の分のデータをリセットする。
        for data in UserData.sharedData.routinesToShow {
            data.doneToday = false
        }
    }
}
