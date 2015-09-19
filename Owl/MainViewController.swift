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
    
    
    //let urlString = "https://api.tripadvisor.com/api/partner/2.0/search/stl?key=HackTripAdvisor-ade29ff43aed"
   // var attsList: Attactions = Attactions()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        /*attsList.load(urlString)  {
            (newsies, errorString) -> Void in
            if let unwrappedErrorString = errorString {
                print(unwrappedErrorString)
            }
            else {
                print("Processdan here")
            }
        }*/
        
        loadCards()
        
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
        
    }*/

    func loadCards() {
        print("Loading Cards");
        let subViewFrame: CGRect = CGRectMake(0, self.navigationController!.navigationBar.frame.size.height+UIApplication.sharedApplication().statusBarFrame.height, self.view.frame.width, self.view.frame.height-UIApplication.sharedApplication().statusBarFrame.height-self.navigationController!.navigationBar.frame.size.height)
        swipeCardsViewBackground = SwipeCardsViewBackground(frame: subViewFrame)
        self.view.addSubview(swipeCardsViewBackground!)
    }
    
}
