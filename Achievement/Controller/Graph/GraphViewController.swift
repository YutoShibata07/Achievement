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
    var graphModel = GraphModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        GraphModel.loadJournals()
        self.graphView.contentMode = .scaleAspectFit
        self.graphView.backgroundColor = UIColor.init(hex: "5EC220")
        print("GraphがAppearしたよ！！！")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        MacawChartView.playAimation()
        
    }
    
    
   
    
    

}
