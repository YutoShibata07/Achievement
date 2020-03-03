//
//  HistoryViewController.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/09/06.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import UIKit
import GoogleMobileAds


@available(iOS 13.0, *)
class HistoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    
    @IBOutlet weak var toCategoryButton: UIButton!
    
    @IBOutlet weak var toDateButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var historyModel = HistoryModel()
    var journalsWithDate = [DateMixedJournal]()
    //日付とジャーナルを合わせた配列。isDate == trueならば削除できないし、文字も太く表示する。
    
    
    
//--------------override-----------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        historyModel.isDate = false
        toCategoryButton.isEnabled = false
        tableView.delegate = self
        
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        historyModel.loadCategories()
        historyModel.loadJournals()
        if historyModel.isDate == nil{
            historyModel.isDate = false
            toCategoryButton.isEnabled = false
            toDateButton.isEnabled = true
        }
        tableView.layer.cornerRadius = 8
        tableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if historyModel.isDate == false{
            if let destionation = segue.destination as? CategoryHistoryViewController{
                destionation.selectedCategory = historyModel.selectedCategory
            }
        }else{
            if let destination = segue.destination as? AddDetailViewController{
                destination.journalTitle = historyModel.selectedJournal
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
    }

    
    
    
//--------------IBAction-------------------------
    @IBAction func toCategoryBtnClicked(_ sender: Any) {
        historyModel.isDate = false
        toCategoryButton.isEnabled = false
        toDateButton.isEnabled = true
        tableView.reloadData()
    }
    
    @IBAction func toDateBtnClicked(_ sender: Any) {
        toDateButton.isEnabled = false
        toCategoryButton.isEnabled = true
        historyModel.isDate = true
        tableView.reloadData()
    }
    
    
    
//-----------------CustomFunctions-----------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        historyModel.loadCategories()
        historyModel.loadJournals()
        if historyModel.isDate == false{ //カテゴリー表示の場合。
            return UserData.sharedData.categoriesToShow.count
        }else{                           //日付表示の場合。
            return HistoryModel.getJournalsWithDate().count
            //挿入する日付の数だけRowSectionの数を増やす。
            
        }
    }
    
    
    //------------------------セルの生成に関して------------------------
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        historyModel.loadJournals()
        historyModel.loadCategories()
        journalsWithDate = HistoryModel.getJournalsWithDate()
        if let categoryCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? HistoryTableViewCell{
            
            if historyModel.isDate == false{//これでカテゴリ毎に表示する
                categoryCell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
                categoryCell.configureCell(
                    title: UserData.sharedData.categoriesToShow[indexPath.row].name,
                    color: UserData.sharedData.categoriesToShow[indexPath.row].color.toUIColor())
                return categoryCell
                
            }else{//これで日付毎に表示する。
                categoryCell.accessoryType = UITableViewCell.AccessoryType.none
                if journalsWithDate.count != 0{
                    categoryCell.notDate = (HistoryModel.getJournalsWithDate()[indexPath.row].isDate == false)
                    //表示するセルが日付なのか日記の内容なのかを渡す。
                    categoryCell.configureDateCell(journal: journalsWithDate[indexPath.row])
                    
                    return categoryCell
                }else{
                    return categoryCell
                }
            }
        }
        return UITableViewCell()
    }
    
    
    
    //---------------------------セル選択時に関してーーーーーーーーーーーーーーーーーーー
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        historyModel.loadJournals()
        historyModel.loadCategories()
        journalsWithDate = HistoryModel.getJournalsWithDate()
        
        
        if historyModel.isDate == false{
            historyModel.selectedCategory = UserData.sharedData.categoriesToShow[indexPath.row]
            performSegue(withIdentifier: "toCategoryHistory", sender: self)
        } else{
            if journalsWithDate[indexPath.row].isDate == true{
                return
                //選択するCellが日付を表示しているのならばセレクトしても何も起きないようにする。
            }
            historyModel.selectedJournal = journalsWithDate[indexPath.row].title
            performSegue(withIdentifier: "toDetailSegue", sender: self)
        }
    }
    
    
    
     //---------------------------セルの消去に関してーーーーーーーーーーーーーーーーーーー
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        
        var numberOfSameDateJournals  = 0
        //同じ日付のjournalを収容する配列。ある日付のJournalが全て消去されたかどうかを判断する。
        
       
        
        if historyModel.isDate == true{
            //---------日付表示だった場合のセル消去について-------------
            if journalsWithDate[indexPath.row].isDate == true{
                return nil   //日付を表示しているセルに対しては削除させないようにする。
            }
            let deleteButton:UITableViewRowAction = UITableViewRowAction(style: .normal, title: "削除") { (action, index) -> Void in
                
                //UserDataの方で消す対象となるJournalを検索する。Title以外はテキトー。
                let deleteIndex = UserData.sharedData.journalsToShow.index(of:Journal.init(title: self.journalsWithDate[indexPath.row].title, isToday: true, categoryName: "", categorycolor: "", creationDate: "",detail: ""))
                
                for journal in UserData.sharedData.journalsToShow {
                    if journal.creationDate == UserData.sharedData.journalsToShow[deleteIndex!].creationDate{
                        numberOfSameDateJournals += 1
                    }
                }
                
                
                self.journalsWithDate.remove(at: indexPath.row)
                UserData.sharedData.journalsToShow.remove(at:deleteIndex!)
                self.historyModel.savedData(UserData.sharedData.journalsToShow)
                
                
                if numberOfSameDateJournals == 1{
                    tableView.reloadData()
                    print(self.journalsWithDate.count)
                    print("indexPath.row\(indexPath.row)")
                }else{tableView.deleteRows(at: [indexPath], with: .fade)}
            }
            
             deleteButton.backgroundColor = UIColor.red
            return [deleteButton]
            
            
        }else{
            //-------------カテゴリー表示だった場合のセルの削除に関して-----------
            let deleteButton:UITableViewRowAction = UITableViewRowAction(style: .normal, title: "削除") { (action, index) -> Void in
                
                //分類なしカテゴリーは消させない。。。
                if UserData.sharedData.categoriesToShow[indexPath.row].name == "分類なし"{
                    self.simpleAlert(title: "アラート表示", msg: "このカテゴリーは消せません")
                }
                
                //アラートを表示する。
                self.categoryAlert { (self) in
                    UserData.sharedData.categoriesToShow.remove(at:indexPath.row)
                    HistoryViewController().historyModel.saveCategories(UserData.sharedData.categoriesToShow)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
                
                
            }
            deleteButton.backgroundColor = UIColor.red
            return [deleteButton]
        }
    }
    
    
}
