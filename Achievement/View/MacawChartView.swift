//
//  MacawChartView.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/10/22.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import Foundation
import Macaw

class MacawChartView:MacawView{
    static let lastSevenShows = createDummyData()
    static let maxValue = 6000
    static let maxValueLineHeight = 180
    static let lineWidth:Double = 385

    static let dataDivisor = Double(maxValue/maxValueLineHeight)
    static let adjustData:[Double] = lastSevenShows.map({$0.viewCount / dataDivisor})
    static var animations :[Animation] = []
    
    

    


    required init?(coder aDecoder: NSCoder) {
        super.init(node:MacawChartView.createChart(), coder: aDecoder)
        backgroundColor = .clear
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
    }

    private static func createChart() -> Group{
        var items :[Node] = addXAxisItems() + addYAxisItems()
        items.append(createBars())

        return Group(contents: items, place: .identity)
    }



    private static func addYAxisItems() -> [Node]{
        let maxLines = 6
        let lineInterval = Int(maxValue/maxLines)
        let yAxisHeight:Double = 200
        let lineSpacing:Double = 30

        var newNodes:[Node] = []

        for i in 1...maxLines {
            let y = yAxisHeight - (Double(i) * lineSpacing)
            //Yの値を表示するためのライン。全部で６本ある。少しY軸より左側から始めるので x1 = -5
            let valueLine = Line(x1: -5, y1: y, x2: lineWidth, y2: y).stroke(fill:Color.white.with(a: 0.10))
            let valueText = Text(text: "\(i * lineInterval)", align: .max, baseline: .mid, place: .move(dx: -10, dy: y))
            valueText.fill = Color.white
            newNodes.append(valueLine)
            newNodes.append(valueText)
        }

        let yAxis = Line(x1: 0, y1: 0, x2: 0, y2: yAxisHeight).stroke(fill:Color.white.with(a: 0.25))

        newNodes.append(yAxis)

        return newNodes
    }

    private static func addXAxisItems() -> [Node]{
        let chartBaseY:Double = 200
        var newNodes:[Node] = []
        
        for i in 1...adjustData.count {
            let x = (Double(i) * 51) //棒グラフの感覚は50
            let valueText = Text(text: lastSevenShows[i - 1].showNumber, align:.max, baseline:.mid, place:.move(dx:x, dy:chartBaseY + 10))//文字はx軸の少し下に置く。
            valueText.fill = Color.white
            newNodes.append(valueText)
        }
        
        let xAxis = Line(x1: 0, y1: chartBaseY, x2: lineWidth, y2: chartBaseY).stroke(fill: Color.white.with(a: 0.5))
        newNodes.append(xAxis)
        return newNodes
    }


    private static func createBars() -> Group{
        let fill = LinearGradient.init(degree: 90, from: Color(val: 0xff4704), to: Color(val:0xff4704).with(a: 0.33))
        let items = adjustData.map{ _ in Group()}
        
        animations = items.enumerated().map{(i: Int, item:Group) in
            item.contentsVar.animation(delay:Double(i) * 0.1){ t in
                let height = adjustData[i] * t
                let rect = Rect(x: Double(i) * 50 + 25, y: 200 - height, w: 30, h: height)
                return [rect.fill(with:fill)]
            }
        }
        
        return items.group()
    }



    static func playAimation(){
        animations.combine().play()
    }

    private static func createDummyData() -> [JournalsCount]{
        let oneWeek = self.getOneWeek()
        let one = JournalsCount(showNumber: oneWeek[0], viewCount: 3456)
        let two = JournalsCount(showNumber: oneWeek[1], viewCount: 5200)
        let three = JournalsCount(showNumber: oneWeek[2], viewCount: 4250)
        let four = JournalsCount(showNumber: oneWeek[3], viewCount: 3600)
        let five = JournalsCount(showNumber: oneWeek[4], viewCount: 4823)
        let six = JournalsCount(showNumber: oneWeek[5], viewCount: 5000)
        let seven = JournalsCount(showNumber: oneWeek[6], viewCount: 4300)

        return [one, two, three, four, five, six , seven]
    }
    
    
    private static  func getOneWeek(format:String = "MM/dd") -> [String]{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        var week:[Date] = []
        var stringWeek :[String] = []
        for i in 1...7{
            var j = 7 - i
            week.append(Date(timeIntervalSinceNow: TimeInterval(-j*24*60*60)))
            stringWeek.append(formatter.string(from: week[i - 1] as Date))
        }
        return stringWeek
    }
    
    
}


