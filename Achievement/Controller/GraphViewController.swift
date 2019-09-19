//
//  GraphViewController.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/09/06.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController {
    let shapeLayer = CAShapeLayer()
    let sharedUserData:UserData = UserData.sharedData
    var achieveRate:Double = 0
    var middleRate:Double = 0
    var NumberOfTask:Int!
    var timer:Timer?
    let percentageLbl:UILabel = {
        let label = UILabel()
        label.text = "Start"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textColor = UIColor.black
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(percentageLbl)
        percentageLbl.frame = CGRect(x: 0, y: 0, width: 130, height: 100)
        percentageLbl.center = view.center
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        middleRate = 0.0
        makePieChart()
        percentageLbl.alpha = 0
    }
    
    func makePieChart(){//達成率を表示する関数。
        sharedUserData.data.doneCount = 0
        NumberOfTask = routines.count
        for task  in routines {
            if task.doneToday == true{
                sharedUserData.data.doneCount += 1
                print(task.title + "もやったよ")
            }
        }
        if NumberOfTask != 0{
            achieveRate = (Double(sharedUserData.data.doneCount) / Double(NumberOfTask!))
        }else{
            achieveRate = 0
        }
        print(achieveRate)
        let trackLayer = CAShapeLayer()
        //デフォルトの枠を作る。
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 100, startAngle: 0, endAngle:
            2 * CGFloat.pi , clockwise: true)
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.position = view.center
        trackLayer.lineWidth = 10
        trackLayer.lineCap = CAShapeLayerLineCap.round
        trackLayer.strokeEnd = 1
        view.layer.addSublayer(trackLayer)
        //        let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.green.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeEnd = 0
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        shapeLayer.position = view.center
        //        shapeLayer.strokeEnd = CGFloat(middleRate)
        print(middleRate)
        view.layer.addSublayer(shapeLayer)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    @objc func handleTap(){
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.duration = 1.5
        shapeLayer.strokeEnd = CGFloat(achieveRate)
        percentageLbl.text = "\(Int(achieveRate * 100))%"
        UIView.animate(withDuration: 0.3, delay: 1.5, options: [.curveEaseIn], animations: {
            self.percentageLbl.alpha = 1
        },completion: nil)
//        basicAnimation.fillMode = CAMediaTimingFillMode.forwards//アニメーションが残り続けるようにする。
//        basicAnimation.isRemovedOnCompletion = false//何回もアニメーションを行えるようにする。
        shapeLayer.add(basicAnimation, forKey: "BasicAnimation")
        return
        
    }
//    func getRate(){//shapeLayer.strokeEndにアニメーションを持たせるためにmiddleRateの値を変化させる。
//        var timer:Timer?
//        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(addRate), userInfo: nil, repeats: true)
//
//    }
//    @objc func addRate(){
//        while middleRate <= achieveRate {
//            self.middleRate += 0.1
//        }
//        print("\(middleRate)だよ")
//        print("Stop!")
//        timer?.invalidate()
//    }
    
    
}
