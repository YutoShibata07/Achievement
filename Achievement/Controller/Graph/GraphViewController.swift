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


@available(iOS 13.0, *)
@available(iOS 13.0, *)
class GraphViewController: UIViewController {
    
    
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var phraseLbl: UILabel!
    
    @IBOutlet weak var graphView: MacawChartView!
//    let graphView = MacawChartView()
    var graphModel = GraphModel()
    var bannerView: GADBannerView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        addBannerViewToView(bannerView)
        bannerView.adUnitID = "ca-app-pub-7252408232726748/4859564922"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        phraseLbl.textColor = .black
        let random:Int!
       
        random = Int.random(in: 0...3)
        switch random {
        case 0:
            phraseLbl.text = "通知機能を活用して復習をするといいかもしれません"
        case 1:
            phraseLbl.text = "この前見た映画、、なんか、、よく覚えてないけどよかったよね。。ハハ"
        case 2:
            phraseLbl.text = "「雑学とかを記録しているのでよく『物知りだね』って言われます。」"
        case 3:
            phraseLbl.text = "通知機能を活用して復習をするといいかもしれません"
        default:
            return
        }
        headingLabel.textColor = .black
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        GraphModel.loadJournals()
        var journalsCount = MacawChartView.createWeekData()      //一週間のデータを取得する。
        MacawChartView.adjustData = journalsCount.map({Double(($0.viewCount)) / MacawChartView.dataDivisor})
        //ViewWillAppearが起きるたびにデータを更新する
        self.graphView.contentMode = .scaleAspectFit
//        if traitCollection.userInterfaceStyle == .dark{
//            graphView.backgroundColor = .black
//
//        }
           
        
        graphView.backgroundColor = UIColor.init(hex: "5EC220")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        MacawChartView.playAimation()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }
}
