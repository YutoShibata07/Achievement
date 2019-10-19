//
//  CategoryHistoryViewController.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/10/14.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class CategoryHistoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var categoryTitleLabel: UILabel!
    @IBOutlet weak var colorView: UIView!
    
    var journalModel = JournalModel()
    var selectedCategory:Category!
    var sortedJournals = [Journal]()
    var selectedJournalTitle:String!
    
    
    
    //----------override-------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        journalModel.loadedData()
        journalModel.changeColorView(colorView: self.colorView, category: selectedCategory)
        journalModel.changeTitle(titleLabel: categoryTitleLabel, category: selectedCategory)
        sortedJournals = journalModel.sortJournal(category: selectedCategory) //表示するカテゴリをソートする。
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AddDetailViewController{
            destination.journalTitle = self.selectedJournalTitle
        }
    }
    
    
    
    
    
    @IBAction func backButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedJournals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let historyCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CategoryHistoryTableViewCell{
            historyCell.configureCell(journal: sortedJournals[indexPath.row].title)
            return historyCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedJournalTitle = sortedJournals[indexPath.row].title
        performSegue(withIdentifier: "toDetailSegue", sender: nil)
    }
       
    
}
