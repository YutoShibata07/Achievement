//
//  CategoryModel.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/10/11.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import Foundation
import UIKit
import StoreKit


class CategoryModel{
    
    let ud = UserDefaults.standard
    
    func decideCategory(colorName:String, categoryName:String){
//        UserData.sharedData.journalsToShow.last.categoryColor = colorName
//        UserData.sharedData.journalsToShow.last?.categoryName = categoryName
       }
    func makeNewJournal(title:String, color:String, categoryName:String, creationDate:String){
        var newJournal = Journal(title: title, isToday: true, categoryName: categoryName, categorycolor: color, creationDate: creationDate)
        UserData.sharedData.journalsToShow.append(newJournal)
    }
    
    func loadJournals(){
        guard let data = ud.data(forKey: "JournalsToShow"),
        let journalsToShow = try? JSONDecoder().decode([Journal].self, from: data) else{return}
        UserData.sharedData.journalsToShow = journalsToShow
        
        guard let numberData = ud.data(forKey: "numberOfJournals"),
            let numberOfJournals = try? JSONDecoder().decode(Int.self, from: numberData) else {return}
        UserData.sharedData.numberOfJournals = numberOfJournals
        return
    }
    
    
    func saveJournals(_ value:[Journal]){
        guard let data = try? JSONEncoder().encode(value) else { return }
        ud.set(data, forKey: "JournalsToShow")
        ud.set(UserData.sharedData.numberOfJournals, forKey: "numberOfJournals")
        ud.synchronize()
    }
    
    func loadCategoris() {
        guard let data = ud.data(forKey: "CategoriesToShow"),
              let loadedData = try? JSONDecoder().decode([Category].self, from: data) else {return}
        UserData.sharedData.categoriesToShow = loadedData
        return
       }
    
    
    func saveCategories(_ value:[Category]){
        guard let data = try? JSONEncoder().encode(value) else { return }
        ud.set(data, forKey: "CategoriesToShow")
        ud.synchronize()
    }
    
    func makeReview(){
        // レビューページへ遷移
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        }
            // iOS 10.3未満の処理
        else {
            if let url = URL(string: "itms-apps://itunes.apple.com/app/id1486176031?action=write-review") {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:])
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
            
        }
    }
    
    
    
    
}
