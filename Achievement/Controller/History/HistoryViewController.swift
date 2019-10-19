//
//  HistoryViewController.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/09/06.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    
    @IBOutlet weak var toCategoryButton: UIButton!
    
    @IBOutlet weak var toDateButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    var categories = [Category]()
    var historyModel = HistoryModel()
    
    
    
//--------------override-----------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        historyModel.isDate = false
        toCategoryButton.isEnabled = false
        tableView.delegate = self
        
        tableView.dataSource = self
//        self.toCategoryButton.isEnabled = false//デフォルトはカテゴリー表示にする。
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        historyModel.loadCategories()
        historyModel.loadJournals()
        categories = UserData.sharedData.categoriesToShow
        if historyModel.isDate == nil{
            historyModel.isDate = false
            toCategoryButton.isEnabled = false
            toDateButton.isEnabled = true
        }
        tableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destionation = segue.destination as? CategoryHistoryViewController{
            destionation.selectedCategory = historyModel.selectedCategory
        }
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let categoryCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? HistoryTableViewCell{
            if historyModel.isDate == false{//これでカテゴリ毎に表示する
                categoryCell.configureCell(title: categories[indexPath.row].name,
                                           color: categories[indexPath.row].color.toUIColor())
                return categoryCell
            }else{//これで日付毎に表示する。
                categoryCell.configureDateCell(title: HistoryModel.getJournalsWithDate()[indexPath.row])
                return categoryCell
            }
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        historyModel.selectedCategory = UserData.sharedData.categoriesToShow[indexPath.row]
        performSegue(withIdentifier: "toCategoryHistory", sender: self)
        
    }
    

  
}
