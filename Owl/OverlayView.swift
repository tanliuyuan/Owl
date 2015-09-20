//
//  OverlayView.swift
//  Owl
//
//  Created by Liuyuan Tan on 9/19/15.
//  Copyright © 2015 Mizzou Hackers. All rights reserved.
//

import Foundation
import UIKit

enum OverlayViewMode : Int {
    case OverlayViewLeft
    case OverlayViewRight
}

class OverlayView: UIView {
    
    var mode: OverlayViewMode
    
    override init(frame:CGRect) {
        mode = OverlayViewMode.OverlayViewLeft
        super.init(frame:frame)
        self.layer.cornerRadius = 10
        self.backgroundColor = UIColor.redColor()
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    func setMode(mode: OverlayViewMode) {
        if mode == OverlayViewMode.OverlayViewLeft {
            self.backgroundColor = UIColor.redColor()
        } else {
            self.backgroundColor = UIColor.greenColor()
        }
    }
    
}