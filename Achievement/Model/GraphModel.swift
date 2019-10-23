//
//  GraphModel.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/10/23.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import Foundation

class GraphModel{
    
      static let ud = UserDefaults.standard
    
    
    
    static func loadJournals(){
        guard let data = ud.data(forKey: "JournalsToShow"),
        let journalsToShow = try? JSONDecoder().decode([Journal].self, from: data) else{return}
        UserData.sharedData.journalsToShow = journalsToShow
        return
    }
    
    
    static func savedData(_ value:[Journal]){
        guard let data = try? JSONEncoder().encode(value) else{return}
        ud.set(data, forKey: "JournalsToShow")
        ud.synchronize()
    }
    
  
    
    
}
