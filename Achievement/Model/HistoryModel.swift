//
//  HistoryModel.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/10/12.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import Foundation
import UIKit



class HistoryModel{
    let ud = UserDefaults.standard
    
    func loadCategories() {
        guard let data = ud.data(forKey: "CategoriesToShow"),
            let loadedData = try? JSONDecoder().decode([Category].self, from: data) else {return}
        
        UserData.sharedData.categoriesToShow = loadedData
        return
    }
    
    func saveCategories(_ value:[Category]){
        guard let data = try? JSONEncoder().encode(value) else { return }
        ud.set(data, forKey: "CategoriewToShow")
        ud.synchronize()
    }
    
}
