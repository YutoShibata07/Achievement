//
//  GraphViewController.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/09/06.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController {

    //-------constants and variables----------
    @IBOutlet weak var commentLbl: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    
    var todoModel = TodoModel()
    let shapeLayer = CAShapeLayer()
    let pulsatingLayer = CAShapeLayer()
    let sharedUserData:UserData = UserData.sharedData
    var achieveRate:Double = 0
    var NumberOfTask:Int!
    var timer:Timer?
    let percentageLbl:UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textColor = UIColor.black
        return label
    }()
    let completedLbl:UILabel = {
       let label = UILabel()
        label.text = "completed"
        label.textAlignment = .center
        label.font =  UIFont.systemFont(ofSize: CGFloat(10))
        label.textColor = UIColor.black
        return label
    }()
    
    
    //-------override-------------------
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        todoModel.loadRoutines()
        percentageLbl.alpha = 0
        completedLbl.alpha = 0
        commentLbl.alpha = 0
        makePieChart()
        characterImage.isHidden = true
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        shapeLayer.strokeEnd = 0
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        shapeLayer.strokeEnd = 0
        startMoveChart()
        print("start!")
    }
    
    
    //--------Custom Functions-----------------
    
    private func changeComment(){
        commentLbl.alpha = 1
        switch achieveRate {
        case 0..<0.4:
            commentLbl.text = "１分でいい。。続けるんや！"
            characterImage.image = UIImage.init(named: "ガンジー")
        case 0.4..<0.7:
            commentLbl.text = "あと半分！！！"
            characterImage.image = UIImage.init(named: "神父")
        case 0.7..<1:
            commentLbl.text = "後少し頑張れえええええ"
            characterImage.image = UIImage.init(named: "メキシカン")
        case 1:
            commentLbl.text = "流石である。あっぱれ"
            characterImage.image = UIImage.init(named: "織田信長")
        default:
            break
        }
    }
    
    private func makePieChart(){//達成率を表示する関数。
        todoModel.loadRoutines()
        sharedUserData.data.doneCount = 0
        NumberOfTask = UserData.sharedData.routinesToShow.count
        for task  in UserData.sharedData.routinesToShow {
            if task.doneToday == true{
                sharedUserData.data.doneCount += 1
            }
        }
        if NumberOfTask != 0{
            achieveRate = (Double(sharedUserData.data.doneCount) / Double(NumberOfTask!))
        }else{
            achieveRate = 0
        }
        //アニメーション用の円を作る。
        createCircleLayer(layer: pulsatingLayer, strokeColor: .clear, fillColor: .init(hex: "EEFFDE"), lineWidth: 10, strokeEnd: 1)
        animatePulsatingLayer()
        //デフォルトの枠を作る。
        let trackLayer = CAShapeLayer()
        createCircleLayer(layer: trackLayer, strokeColor: .lightGray, fillColor: .white, lineWidth: 20, strokeEnd: 1)
        createCircleLayer(layer: shapeLayer, strokeColor: .init(hex: "5EC220"), fillColor: .clear, lineWidth: 20, strokeEnd: 0)
        view.addSubview(percentageLbl)
        percentageLbl.frame = CGRect(x: 0, y: 0, width: 130, height: 100)
        percentageLbl.center = view.center
        view.addSubview(completedLbl)
        completedLbl.topAnchor.constraint(equalTo: self.percentageLbl.bottomAnchor, constant: 5).isActive = true
        completedLbl.leadingAnchor.constraint(equalTo: percentageLbl.leadingAnchor).isActive = true
//        completedLbl.widthAnchor.constraint(equalTo: percentageLbl.widthAnchor).isActive = true
//        completedLbl.topAnchor.constraint(equalTo: percentageLbl.bottomAnchor, constant: 20).isActive = true
        shapeLayer.strokeEnd = 0
    }
   
    private func createCircleLayer(layer:CAShapeLayer, strokeColor:UIColor, fillColor:UIColor, lineWidth:Int,strokeEnd:Int){
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 100, startAngle: 0, endAngle:
            2 * CGFloat.pi , clockwise: true)
        layer.path = circularPath.cgPath
        layer.strokeColor = strokeColor.cgColor
        layer.fillColor = fillColor.cgColor
        layer.position = view.center
        layer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        layer.lineWidth = CGFloat(lineWidth)
        layer.lineCap = CAShapeLayerLineCap.round
        layer.strokeEnd = CGFloat(strokeEnd)
        view.layer.addSublayer(layer)
    }
    
    func startMoveChart(){
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.duration = 1.3
        shapeLayer.strokeEnd = CGFloat(achieveRate)
        percentageLbl.text = "\(Int(achieveRate * 100))%"
        UIView.animate(withDuration: 0.3, delay: 1.5, options: [.curveEaseIn], animations: {
            self.completedLbl.alpha = 1
            self.percentageLbl.alpha = 1
            self.characterImage.isHidden = false
            self.changeComment()
        },completion: nil)
//        basicAnimation.fillMode = CAMediaTimingFillMode.forwards//アニメーションが残り続けるようにする。
//        basicAnimation.isRemovedOnCompletion = false//何回もアニメーションを行えるようにする。
        shapeLayer.add(basicAnimation, forKey: "BasicAnimation")
        return
    }
    private func animatePulsatingLayer(){
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = 1.3
        animation.duration = 0.8
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        pulsatingLayer.add(animation, forKey: "pulsing")
    }
}
