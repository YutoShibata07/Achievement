//
//  FadeEnableButton.swift
//  Achievement
//
//  Created by 柴田優斗 on 2019/09/09.
//  Copyright © 2019 柴田優斗. All rights reserved.
//

import Foundation
import  UIKit

class FadeEnableBtn: UIButton {
    override var isEnabled: Bool{
        didSet{
            if isEnabled{
                UIView.animate(withDuration: 0.2){
                    self.alpha = 1.0
                }
            }else{
                UIView.animate(withDuration: 0.2){
                    self.alpha = 0.3
                }
            }
        }
    }
}
