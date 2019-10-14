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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.toCategoryButton.isEnabled = false//デフォルトはカテゴリー表示にする。
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        historyModel.loadCategories()
        categories = UserData.sharedData.categoriesToShow
        tableView.reloadData()
    }
    
    @IBAction func toCategoryButtonClicked(_ sender: Any) {
        toCategoryButton.isEnabled = false
        toDateButton.isEnabled = true
    }
    
    @IBAction func toDateBtnClicked(_ sender: Any) {
        print("はい")
        toCategoryButton.isEnabled = true
        toDateButton.isEnabled = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserData.sharedData.categoriesToShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let categoryCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? HistoryTableViewCell{
            categoryCell.configureCell(title: categories[indexPath.row].name,
                                       color: categories[indexPath.row].color.toUIColor())
            return categoryCell
        }
        
        return UITableViewCell()
    }
    
    
    

    
}
