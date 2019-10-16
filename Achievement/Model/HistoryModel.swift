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
    var isDate:Bool! //現在開いているページが日付表示かカテゴリー表示か
    var selectedCategory:Category!
    var numberOfDate:Int! = 0   //途中で挿入する日付の数
    var numberOfShowingDate:Int! = 0//既に表示されている日付の数。
    
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
    func loadJournals(){
        guard let data = ud.data(forKey: "JournalsToShow"),
        let journalsToShow = try? JSONDecoder().decode([Journal].self, from: data) else{return}
        UserData.sharedData.journalsToShow = journalsToShow
        return
    }
    
    static func getJournalsWithDate() -> [String]{
        UserData.sharedData.journalsReversed = UserData.sharedData.journalsToShow.reversed()
        var journalsWithDate = [String]()
        var journalsReversed = UserData.sharedData.journalsReversed
        for i in 0...journalsReversed.count - 1{
            if i == 0{
                journalsWithDate.append(contentsOf:[journalsReversed[i].creationDate,                journalsReversed[i].title])
            }else if i == journalsReversed.count - 1{
                journalsWithDate.append(journalsReversed[i].title)
            }else if journalsReversed[i].creationDate != journalsReversed[i + 1].creationDate{
                journalsWithDate.append(contentsOf:[journalsReversed[i].title,                journalsReversed[i + 1].creationDate])
            }else{
                journalsWithDate.append(journalsReversed[i].title)
            }
        }
        for journal in journalsWithDate {
            print(journal)
        }
        return journalsWithDate
    }
    
}
