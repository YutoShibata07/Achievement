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
    
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    @IBOutlet weak var graphView: MacawChartView!
//    let graphView = MacawChartView()
    var graphModel = GraphModel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        GraphModel.loadJournals()
       
//        //自分でViewを設置する。
//        self.view.addSubview(graphView)
//
//        graphView.translatesAutoresizingMaskIntoConstraints = false
//        graphView.topAnchor.constraint(equalTo:self.dateLabel.bottomAnchor, constant: 30)
//        graphView.leadingAnchor.constraint(equalTo:self.view.leadingAnchor, constant: 20).isActive = true
//        graphView.trailingAnchor.constraint(equalTo:self.view.leadingAnchor, constant: 20).isActive = true
//        graphView.heightAnchor.constraint(equalTo:graphView.widthAnchor, constant: 0).isActive = true
//
//        
//
        self.graphView.contentMode = .scaleAspectFit
        graphView.backgroundColor = UIColor.init(hex: "5EC220")
        print("GraphがAppearしたよ！！！")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        MacawChartView.playAimation()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
    }

}
