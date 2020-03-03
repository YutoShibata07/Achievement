//
//  QuestionViewController.swift
//  Achievement
//
//  Created by 柴田優斗 on 2020/01/12.
//  Copyright © 2020 柴田優斗. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.titleLabel.layer.cornerRadius = 8
        self.backButton.layer.cornerRadius = 8
    }
    

    @IBAction func backButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
