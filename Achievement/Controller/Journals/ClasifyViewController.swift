//
//  ClasifyViewController.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/09/23.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import UIKit

class ClasifyViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    //--------Variable------------
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var newJournal:String = ""
    
    @IBOutlet weak var returnBtn: UIButton!
    var categoryModel =  CategoryModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserData.sharedData.categoriesToShow.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let classifyCell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? ClassifyTableViewCell{
            classifyCell.configureCell(text: UserData.sharedData.categoriesToShow[indexPath.row].name, color: UserData.sharedData.categoriesToShow[indexPath.row].color)
            //カテゴリ名とカラーを表示させる。ここまでは上手くいってる。
            return classifyCell
        }
        return UITableViewCell()
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        categoryModel.loadCategoris()//カテゴリをロードする。→後で保存
        categoryModel.makeNewJournal(
            title: newJournal, //NewJournalVCから送られてきたnewJournalのタイトル。
            color: UserData.sharedData.categoriesToShow[indexPath.row].color,
            categoryName: UserData.sharedData.categoriesToShow[indexPath.row].name
        )
        categoryModel.saveJournals(UserData.sharedData.journalsToShow)  //新たに要素が追加されたjournalsToShowを保存する。
        
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion:{
            [presentingViewController] () -> Void in
            presentingViewController?.presentingViewController?.viewWillAppear(true)
        })//dismiss と同時に先頭のviewControllerのviewWillAppearを発動させたい。。。。。できない・・・・
        
    }
    
    @IBAction func returnBtnClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
  
    
}
