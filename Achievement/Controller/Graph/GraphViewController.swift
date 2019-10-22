//
//  GraphViewController.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/10/19.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import UIKit
import Macaw

class GraphViewController: UIViewController {
    
    
    @IBOutlet weak var graphView: MacawChartView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        graphView.contentMode = .scaleAspectFit
        graphView.backgroundColor = UIColor.init(hex: "5EC220")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        graphView.layer.cornerRadius = 8
    }
    
    override func viewDidAppear(_ animated: Bool) {
        MacawChartView.playAimation()
    }
    

}
