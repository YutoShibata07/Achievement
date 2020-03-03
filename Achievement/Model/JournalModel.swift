//
//  JounalModel.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/10/02.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class JournalModel{
    
    
    let ud = UserDefaults.standard
    var lastVisitTime:Date!
    
    
    func sortDisplayingJournal(journals:[Journal], VC:UIViewController) -> [Journal]{
        var displayingJournals = [Journal]()
        for journal in journals{
            if journal.creationDate == VC.getToday(){
                displayingJournals.append(journal)
            }
        }
        
        return displayingJournals
    }
    
    
    func loadedData(){
        guard let data = ud.data(forKey: "JournalsToShow"),
            let journalsToShow = try? JSONDecoder().decode([Journal].self, from: data) else{return}
        UserData.sharedData.journalsToShow = journalsToShow       
        return
    }
    
    func savedData(_ value:[Journal]){
        guard let data = try? JSONEncoder().encode(value) else{return}
        ud.set(data, forKey: "JournalsToShow")
        ud.synchronize()
    }
    
    func resetData(){//今日の分のデータをリセットする。
        for data in UserData.sharedData.journalsToShow {
            data.isToday = false
        }
    }
    
    func changeColorView(colorView:UIView, category:Category){
        colorView.backgroundColor = category.color.toUIColor()
    }
    func changeTitle(titleLabel:UILabel, category:Category){
        titleLabel.text = category.name
    }
    func sortJournal(category:Category) -> [Journal]{
        var sortedJournals = [Journal]()
        loadedData()
        for journal in UserData.sharedData.journalsToShow {
            if journal.categoryName == category.name{
                sortedJournals.append(journal)
            }
        }
        return sortedJournals
    }
    
    func saveEmotionalJournals(_ value:[Journal]){
        guard let data = try? JSONEncoder().encode(value) else{return}
        ud.set(data, forKey: "emotionalJournals")
        ud.synchronize()
    }
    
   
}
