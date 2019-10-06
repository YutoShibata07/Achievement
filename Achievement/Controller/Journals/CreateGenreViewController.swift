//
//  CreateGenreTableViewCell.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/10/06.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import UIKit

class CreateGenreViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    
    //-------override-----------
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
        addButton.layer.cornerRadius = 8
        cancelButton.layer.cornerRadius = 8
    }

    
    
    //------Custom Funtions------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let colors = Colors()
        print(colors.colors.count)
        return colors.colors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let colorCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? SelectColorTableViewCell{
            colorCell.configureCell(text: Colors().names[indexPath.row], color: Colors().colors[indexPath.row])
            return colorCell
        }
        return UITableViewCell()
    }
    
    @IBAction func addButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
