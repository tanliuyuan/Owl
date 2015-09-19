//
//  MainViewController.swift
//  Owl
//
//  Created by Liuyuan Tan on 9/19/15.
//  Copyright © 2015 Mizzou Hackers. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    //var allArticles: [ArticleData]?
    var swipeCardsViewBackground: SwipeCardsViewBackground?
    //var testArticles: ReadingList?
    
    
    let urlString = "https://api.tripadvisor.com/api/partner/2.0/search/stl?key=HackTripAdvisor-ade29ff43aed"
    var attsList: Attactions = Attactions()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        attsList.load(urlString)  {
            (newsies, errorString) -> Void in
            if let unwrappedErrorString = errorString {
                print(unwrappedErrorString)
            }
            else {
                print("Processdan here")
            }
        }

        
        
       // scheduleLocalNotifications()
        
        //create the time and repeat every 12 hours
       // let test: NSTimer = NSTimer(fireDate: checkWhichDate(), interval: 5, target: self, selector: "loadCards", userInfo: nil, repeats: true)
       // NSRunLoop.currentRunLoop().addTimer(test, forMode: NSRunLoopCommonModes)
        
        //loadCards()
        
    }
    /*
    @IBAction func gotoReadingList(sender: AnyObject) {
        print("Going to reading list")
        performSegueWithIdentifier("CowToList", sender: CardViewController())
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("preparing for segue")
        let comp: String? = "CowToList"
        if(segue.identifier == comp) {
            let destViewController = segue.destinationViewController as! ReadingListViewController
            
            // destViewController.allArticles = swipeCardsViewBackground!.toReadingList
            destViewController.testArticles = swipeCardsViewBackground!.testArticles
        }
        
    }
    
    @IBAction func returnToCards(segue: UIStoryboardSegue) {
        
    }
    
    func scheduleLocalNotifications() {
        let dateString1 = "2000-01-01 8:00"
        let dateString2 = "2000-01-01 20:00"
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        formatter.timeZone = NSTimeZone.systemTimeZone()
        let fireDate1 = formatter.dateFromString(dateString1)
        let fireDate2 = formatter.dateFromString(dateString2)
        
        let localNotification = UILocalNotification()
        localNotification.alertAction = "Sea Cow"
        localNotification.alertBody = "Hey! Sea Cow's got you some news!"
        localNotification.soundName = UILocalNotificationDefaultSoundName
        // set first notification time
        localNotification.fireDate = fireDate1
        // repeat notification daily
        localNotification.repeatInterval = NSCalendarUnit.Day
        // schedule first notification
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        // set second notification time
        localNotification.fireDate = fireDate2
        // schedule second notification
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }*/
    
    
    
    func loadCards() {
        print("Loading Cards");
        let subViewFrame: CGRect = CGRectMake(0, self.navigationController!.navigationBar.frame.size.height+UIApplication.sharedApplication().statusBarFrame.height, self.view.frame.width, self.view.frame.height-UIApplication.sharedApplication().statusBarFrame.height-self.navigationController!.navigationBar.frame.size.height)
        swipeCardsViewBackground = SwipeCardsViewBackground(frame: subViewFrame)
        self.view.addSubview(swipeCardsViewBackground!)
    }
    
}
