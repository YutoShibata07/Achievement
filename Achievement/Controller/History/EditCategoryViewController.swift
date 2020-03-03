//
//  EditCategoryViewController.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/11/20.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class EditCategoryViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate{
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var saveButton: UIButton!
    
    var categoryModel = CategoryModel()
    var selectedColor:String!
    var edittedCategory:String!
    var edittedJournals:[Journal]!
    
    
    //-------override-----------
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        textField.delegate = self
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
        saveButton.layer.cornerRadius = 8
        cancelButton.layer.cornerRadius = 8
        categoryModel.loadCategoris()
        textField.text = edittedCategory
        let previousColorIndex = UserData.DefaultColors().names.firstIndex(of:selectedColor)!
        self.tableView.selectRow(at: IndexPath(row: previousColorIndex, section: 0), animated: true, scrollPosition: .none)
    }
    
    
    
    //------Custom Funtions------------
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserData.DefaultColors().names.count
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //選択された色に更新する。
        selectedColor = UserData.DefaultColors().names[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let colorCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? SelectColorTableViewCell{
            colorCell.configureCell(colorName: UserData.DefaultColors().names[indexPath.row],
                                    color: UserData.DefaultColors().names[indexPath.row].toUIColor())
            return colorCell
        }
        return UITableViewCell()
    }
    
   
    
    
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        categoryModel.loadCategoris()
        
        guard let newCategoryTitle = textField.text , newCategoryTitle.isNotEmpty == true
            else{
                simpleAlert(title: "エラー", msg: "カテゴリーのタイトルが入力されていません")
                return
        }
        guard let categoryIndex = UserData.sharedData.categoriesToShow.index(of: Category(name: self.edittedCategory, color: "")) else{return}
        
        //CategoriesToShowの値を更新する
        UserData.sharedData.categoriesToShow[categoryIndex].name = self.textField.text
        UserData.sharedData.categoriesToShow[categoryIndex].color = self.selectedColor
        categoryModel.saveCategories(UserData.sharedData.categoriesToShow)
        
        for edittedJournal in edittedJournals{
            edittedJournal.categoryName = self.textField.text ?? ""
            edittedJournal.categoryColor = self.selectedColor
        }
        
        dismiss(animated: true, completion: {
            [presentingViewController] () -> Void in
            // 閉じた時に行いたい処理
            presentingViewController?.viewWillAppear(true)
            print(presentingViewController)
        })
    }
    
    

}
