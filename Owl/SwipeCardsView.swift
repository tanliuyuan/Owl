//
//  SwipeCardsView.swift
//  Owl
//
//  Created by Liuyuan Tan on 9/19/15.
//  Copyright © 2015 Mizzou Hackers. All rights reserved.
//

/*import Foundation
import UIKit

let ACTION_MARGIN = 50 // Distance from center when action is triggered. Higher = swipe further for the action to be called
let SCALE_STRENGTH = 4 // How quick the card shrinks. Higher = slower shrinkng
let SCALE_MAX: CGFloat = 0.93 // How much the card can shrink. Higher = shrinks less
let ROTATION_STRENGTH = 320 // Strength of rotation. Higher = weaker rotation
let ROTATION_MAX = 1 /// Maximum rotation allowed in radians. Higher = longer rotation time
let ROTATION_ANGLE = M_PI/8 // Higher = larger rotation angle

class SwipeCardsView: UIView {
    
    var xFromCenter: CGFloat
    var yFromCenter: CGFloat
    var panGestureRecognizer: UIPanGestureRecognizer
    var originalPoint: CGPoint
    var overlayView: OverlayView
    var backgroundView: UIImageView
    var gradientView: UIImageView
    var label: UILabel
    var articleData: ArticleData
    
    required init?(coder aDecoder: NSCoder) {
        xFromCenter = 0.0
        yFromCenter = 0.0
        panGestureRecognizer = UIPanGestureRecognizer()
        originalPoint = CGPoint()
        overlayView = OverlayView(coder: aDecoder)!
        backgroundView = UIImageView()
        gradientView = UIImageView()
        label = UILabel()
        articleData = ArticleData()
        
        super.init(coder: aDecoder)
        
        let gradientImage = UIImage(named: "gradient.png")
        gradientView = UIImageView(image: gradientImage)
        gradientView.contentMode = UIViewContentMode.ScaleAspectFill
        
        label.text = "No Data"
        
    }
    
    override init(frame: CGRect){
        xFromCenter = 0.0
        yFromCenter = 0.0
        panGestureRecognizer = UIPanGestureRecognizer()
        originalPoint = CGPoint()
        overlayView = OverlayView(coder: NSCoder())!
        backgroundView = UIImageView()
        gradientView = UIImageView()
        label = UILabel()
        articleData = ArticleData()
        
        super.init(frame: frame)
        
        label = UILabel(frame: CGRectMake(self.frame.size.width * 0.05, self.frame.size.height * 0.6, self.frame.size.width * 0.85, self.frame.size.height * 0.4))
        label.textAlignment = NSTextAlignment.Natural
        label.textColor = UIColor.whiteColor()
        label.font = UIFont(name: "Gotham Bold", size: 24)
        label.numberOfLines = 0
        
        let backgroundImage = UIImage(named: "cardbackground.png")
        backgroundView = UIImageView(frame: CGRectMake(0, 0, self.frame.size.width , self.frame.size.height))
        backgroundView.image = backgroundImage
        
        let gradientImage = UIImage(named: "gradient.png")
        gradientView = UIImageView(frame: CGRectMake(0, 0, self.frame.size.width , self.frame.size.height))
        gradientView.image = gradientImage
        
        setupView()
        
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "beingDragged:")
        
        self.addGestureRecognizer(panGestureRecognizer)
        
        overlayView = OverlayView(frame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height))
        overlayView.alpha = 0
        self.addSubview(overlayView)
        
        self.superview
    }
    
    func setupView() {
        self.layer.cornerRadius = 10
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSizeMake(0.5, 1.5)
        
        self.addSubview(backgroundView)
        backgroundView.contentMode = UIViewContentMode.ScaleAspectFill
        self.addSubview(gradientView)
        gradientView.contentMode = UIViewContentMode.ScaleToFill
        self.addSubview(label)
        
        self.backgroundView.layer.cornerRadius = 10
        self.backgroundView.layer.masksToBounds = true
        self.gradientView.layer.cornerRadius = 10
        self.gradientView.layer.masksToBounds = true
    }
    
    // This function is called when the user's finger touches and pans over the screen
    func beingDragged(gestureRecognizer: UIPanGestureRecognizer) {
        
        // .translationInView extracts the coordinate data from the swipe movement
        xFromCenter = gestureRecognizer.translationInView(self).x
        yFromCenter = gestureRecognizer.translationInView(self).y
        
        // .state checks whether user is starting, panning, or letting go of the card
        switch (gestureRecognizer.state) {
            
        case UIGestureRecognizerState.Began:
            self.originalPoint = self.center
            
        case UIGestureRecognizerState.Changed:
            let rotationStrength = min(CGFloat(xFromCenter) / CGFloat(ROTATION_STRENGTH), CGFloat(ROTATION_MAX)) as CGFloat
            let rotationAngle: CGFloat = (CGFloat(ROTATION_ANGLE) * rotationStrength)
            let scale = max((CGFloat(1) - CGFloat(rotationStrength) / CGFloat(SCALE_STRENGTH)), SCALE_MAX) as CGFloat
            self.center = CGPointMake(self.originalPoint.x + xFromCenter, self.originalPoint.y + yFromCenter)
            let transform: CGAffineTransform = CGAffineTransformMakeRotation(rotationAngle)
            let scaleTransform: CGAffineTransform = CGAffineTransformScale(transform, scale, scale)
            self.transform = scaleTransform
            self.updateOverlay(xFromCenter)
            
        case UIGestureRecognizerState.Ended:
            self.afterSwipeAction()
            
        case UIGestureRecognizerState.Possible:break
        case UIGestureRecognizerState.Cancelled:break
        case UIGestureRecognizerState.Failed:break
        }
    }
    
    // Checks to see if user's moving right or left and applies the corresponding overlay image
    func updateOverlay(distance: CGFloat) {
        // If card is being dragged to the right
        if distance > 0 {
            overlayView.setMode(OverlayViewMode.OverlayViewRight)
        } else if distance < 0 { // If card is being dragged to the left
            overlayView.setMode(OverlayViewMode.OverlayViewLeft)
        }
        
        overlayView.alpha = min(CGFloat(abs(distance))/100, 0.4)
    }
    
    // Called when the card is let go
    func afterSwipeAction() {
        if xFromCenter > CGFloat(ACTION_MARGIN) {
            self.rightAction(self.superview as! SwipeCardsViewBackground)
        }
        else if xFromCenter < CGFloat(-ACTION_MARGIN) {
            self.leftAction(self.superview as! SwipeCardsViewBackground)
        }
        else {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.center = self.originalPoint
                self.transform = CGAffineTransformMakeRotation(0)
                self.overlayView.alpha = 0
            })
        }
    }
    
    // Called when user swipes right
    func rightAction(background: SwipeCardsViewBackground) {
        let finishPoint: CGPoint = CGPointMake(500, 2 * yFromCenter + self.originalPoint.y)
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.center = finishPoint
            }) { (complete) -> Void in
                self.removeFromSuperview()
        }
        background.swipeRight()
        print("YES")
    }
    
    // Called when user swipes left
    func leftAction(background: SwipeCardsViewBackground) {
        let finishPoint: CGPoint = CGPointMake(-500, 2 * yFromCenter + self.originalPoint.y)
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.center = finishPoint
            }) { (complete) -> Void in
                self.removeFromSuperview()
        }
        background.swipeLeft()
        print("NO")
    }
    
}*/