//
//  JounalModel.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/10/02.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import Foundation

class JournalModel{
    let ud = UserDefaults.standard
    
    func loadedData(){
        guard let data = ud.data(forKey: "JournalsToShow"),
        let journalsToShow = try? JSONDecoder().decode([Journals].self, from: data) else{return}
        UserData.sharedData.journalsToShow = journalsToShow
        return
    }
}
