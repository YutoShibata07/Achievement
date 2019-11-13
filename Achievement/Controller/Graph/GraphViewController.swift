//
//  GraphViewController.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/10/19.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import UIKit
import Macaw
import GoogleMobileAds


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
        var journalsCount = MacawChartView.createWeekData()      //一週間のデータを取得する。
        MacawChartView.adjustData = journalsCount.map({Double(($0.viewCount)) / MacawChartView.dataDivisor})
        //ViewWillAppearが起きるたびにデータを更新する
        self.graphView.contentMode = .scaleAspectFit
        graphView.backgroundColor = UIColor.init(hex: "5EC220")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        MacawChartView.playAimation()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
    }
    
//    override func viewDidLayoutSubviews(){
//        //  広告インスタンス作成
//        var admobView = GADBannerView()
//        admobView = GADBannerView(adSize:kGADAdSizeBanner)
//
//        //  広告位置設定
//        let safeArea = self.view.safeAreaInsets.bottom
//        admobView.frame.origin = CGPoint(x:0, y:self.view.frame.size.height - safeArea - admobView.frame.height)
//        admobView.frame.size = CGSize(width:self.view.frame.width, height:admobView.frame.height)
//
//        //  広告ID設定ca-app-pub-7252408232726748/4859564922
//        admobView.adUnitID = "ca-app-pub-7252408232726748/4859564922"
//
//        //  広告表示
//        admobView.rootViewController = self
//        admobView.load(GADRequest())
//        self.view.addSubview(admobView)
//    }
}
