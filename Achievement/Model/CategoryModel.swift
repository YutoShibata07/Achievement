//
//  CategoryModel.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/10/11.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import Foundation
import UIKit

class CategoryModel{
    
    let ud = UserDefaults.standard
    
    func decideCategory(colorName:String, categoryName:String){
//        UserData.sharedData.journalsToShow.last.categoryColor = colorName
//        UserData.sharedData.journalsToShow.last?.categoryName = categoryName
       }
    func makeNewJournal(title:String, color:String, categoryName:String){
        var newJournal = Journals(title: title, isToday: true, categoryName: categoryName, categorycolor: color)
        UserData.sharedData.journalsToShow.append(newJournal)
    }
    
    func loadJournals(){
        guard let data = ud.data(forKey: "JournalsToShow"),
        let journalsToShow = try? JSONDecoder().decode([Journals].self, from: data) else{return}
        UserData.sharedData.journalsToShow = journalsToShow
        return
    }
    
    
    func saveJournals(_ value:[Journals]){
        guard let data = try? JSONEncoder().encode(value) else { return }
        ud.set(data, forKey: "JournalsToShow")
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
    
    
    
    
}
