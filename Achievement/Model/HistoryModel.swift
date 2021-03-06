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
    var selectedJournal:String!
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
        ud.set(data, forKey: "CategoriesToShow")
        ud.synchronize()
    }
    func loadJournals(){
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
    
    
    static func getJournalsWithDate() -> [DateMixedJournal]{
        
        UserData.sharedData.journalsReversed = UserData.sharedData.journalsToShow.reversed()
        var journalsWithDate = [DateMixedJournal]()
        if UserData.sharedData.journalsReversed.count != 0{
            
            var journalsReversed = UserData.sharedData.journalsReversed
            for i in 0...journalsReversed.count - 1{
                if i == 0{//一つ目の要素は何があっても日付を挿入する。
                    journalsWithDate.append(
                        contentsOf:[DateMixedJournal(title: journalsReversed[i].creationDate, isDate:true),
                                    
                                    DateMixedJournal(title: journalsReversed[i].title, isDate: false)])
                }else if journalsReversed[i].creationDate != journalsReversed[i - 1].creationDate{
                    //前の要素の日にちと違かったら日付を挿入してからジャーナルのタイトルを加える。
                    journalsWithDate.append(
                        contentsOf:[DateMixedJournal(title: journalsReversed[i].creationDate,isDate: true),
                                    DateMixedJournal(title: journalsReversed[i].title, isDate: false)])
                }else{//普通にジャーナルを追加する。
                    journalsWithDate.append(DateMixedJournal(title: journalsReversed[i].title, isDate: false))
                }
            }
        }
        return journalsWithDate
    }
    
}
