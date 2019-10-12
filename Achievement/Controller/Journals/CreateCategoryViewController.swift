//
//  CreateGenreTableViewCell.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/10/06.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import UIKit

class CreateCategoryViewController: UIViewController, UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    var categoryModel = CategoryModel()
    var selectedColor:String!
    var newCategory:String!
    
    
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
        addButton.layer.cornerRadius = 8
        cancelButton.layer.cornerRadius = 8
        categoryModel.loadCategoris()
    }

    
    
    //------Custom Funtions------------
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DefaultColors().names.count
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedColor = DefaultColors().names[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let colorCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? SelectColorTableViewCell{
            colorCell.configureCell(colorName: DefaultColors().names[indexPath.row],
                                    color: DefaultColors().names[indexPath.row].toUIColor())
            return colorCell
        }
        return UITableViewCell()
    }
    
    @IBAction func addButtonClicked(_ sender: Any) {
        categoryModel.loadCategoris()
        
        guard let newCategoryTitle = textField.text , newCategoryTitle.isNotEmpty == true
            else{
                simpleAlert(title: "エラー", msg: "カテゴリーのタイトルが入力されていません")
                return
        }
        
        guard let selectedColor = selectedColor else{
            simpleAlert(title: "エラー", msg: "カラーが選択されていません")
            return }
        UserData.sharedData.categoriesToShow.append(Category(name: newCategoryTitle, color: selectedColor))
        print(UserData.sharedData.categoriesToShow)
        categoryModel.saveCategories(UserData.sharedData.categoriesToShow)
        
        dismiss(animated: true, completion: {
                [presentingViewController] () -> Void in
                    // 閉じた時に行いたい処理
                    presentingViewController?.viewWillAppear(true)
        })
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
   
    
}
