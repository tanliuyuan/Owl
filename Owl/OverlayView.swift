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
    //var imageView: UIImageView
    
    override init(frame:CGRect) {
        mode = OverlayViewMode.OverlayViewLeft
        //imageView = UIImageView()
        super.init(frame:frame)
        self.layer.cornerRadius = 10
        self.backgroundColor = UIColor.redColor()
        //imageView = UIImageView(image: UIImage(named: "noButton"))
        //self.addSubview(imageView)
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    func setMode(mode: OverlayViewMode) {
        if mode == OverlayViewMode.OverlayViewLeft {
            self.backgroundColor = UIColor.redColor()
            //imageView.image = UIImage(named: "noButton")
        } else {
            self.backgroundColor = UIColor.greenColor()
            //imageView.image = UIImage(named: "yesButton")
        }
    }
    
}