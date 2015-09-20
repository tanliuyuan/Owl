//
//  SwipeCardsViewBackground.swift
//  Owl
//
//  Created by Liuyuan Tan on 9/19/15.
//  Copyright © 2015 Mizzou Hackers. All rights reserved.
//
import Foundation
import UIKit

// A set of constant and variable strings for making up the URL for article searching using TripAdvisor's API
let attSearchBaseURL = "https://api.tripadvisor.com/api/partner/2.0/search"
let attSearchAPIKey = "4695B5894B33493BA4A0389F61843655"
var attSearchLocation = "BeiJing"

class SwipeCardsViewBackground: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let MAX_CARD_NUM: Int = 2 // maximum number of cards loaded at any given time, must be greater than 1
    let CARD_HEIGHT: CGFloat = UIScreen.mainScreen().bounds.size.height * 0.75
    let CARD_WIDTH: CGFloat = UIScreen.mainScreen().bounds.size.width * 0.9
    
    var loaded: Int = 0 // number of cards loaded
    var deck = [SwipeCardsView]() // array of loaded cards
    
    var allCards = [SwipeCardsView]() // array of all cards
    
    //var nytArticles = NYTArticles()
    var attractions: Attactions = Attactions()
    
    var selectedAttraction: Attaction?
    var toAttractionList: [Attaction] = []
    var done = false
    var testAttractions: AttractionList = AttractionList()
    
    override init(frame: CGRect) {
        
        super.init(frame:frame)
        
        if(testAttractions.load() == true) {
            print("Reading List successfully loaded")
        }
        
        // prepare a loading indicator
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        indicator.frame = CGRectMake(self.frame.width * 19/40, (self.frame.height - self.frame.width / 20) / 2, self.frame.width / 20, self.frame.width / 20)
        self.addSubview(indicator)
        indicator.bringSubviewToFront(self)
        
        // start loading indicator before loading cards
        indicator.startAnimating()
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        
        //var stringTitles: [String] = []
        // Make up search url
        let attSearchURL = attSearchBaseURL + "/" + attSearchLocation + "?" + "key=" + attSearchAPIKey
        
        // load articles from the NYT API
        //print(attSearchURL)
        attractions.load(attSearchURL, completionHandler: {
            (attractions, errorString) -> Void in
            if let unwrappedErrorString = errorString {
                print(unwrappedErrorString)
            } else {
                
                sleep(2)
                
                print("Enter else TEST")
                for attraction in attractions.newAtt {
                    print(attractions.newAtt.count)
                    let card = SwipeCardsView()
                    let labelTextStyle = NSMutableParagraphStyle()
                    labelTextStyle.lineSpacing = 10
                    labelTextStyle.lineBreakMode = NSLineBreakMode.ByWordWrapping
                    let attributes = [NSParagraphStyleAttributeName : labelTextStyle]
                    card.label.attributedText = NSAttributedString(string: attraction.AttName, attributes:attributes)
                    card.attractionData = attraction
                    if let imageUrl = NSURL(string: card.attractionData.PhotoURL) {
                        if let imageData = NSData(contentsOfURL: imageUrl){
                            card.backgroundView = UIImageView(image: UIImage(data: imageData)!)
                        }
                    }
                    self.allCards.append(card)
                }
                print("Total number of cards:\(self.allCards.count)")
                self.loaded = 0
                self.loadCards()
                
                // stop loading indicator after cards are loaded
                indicator.stopAnimating()
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            }
        })
    }
    
    func loadCards() {
        
        if allCards.count > 0 {
            // make sure max card load is smaller than actual deck size
            let numLoadedCardsCap = allCards.count > MAX_CARD_NUM ? MAX_CARD_NUM : allCards.count
            
            // loop through the exampleCardsLabels array to create a card for each label. This should be customerized by removing "exampleCardLabels" with another array of data
            for var i = 0 ; i < allCards.count; i++ {
                let newCard: SwipeCardsView = self.createSwipeCardsViewWithDataAtIndex(i)
                
                if i < numLoadedCardsCap {
                    // add some extra cards to be loaded
                    deck.append(newCard)
                }
            }
        }
        
        // display extra loaded cards
        for var i = 0; i < deck.count; i++ {
            if i > 0 {
                self.insertSubview(deck[i] as UIView, belowSubview: deck[i-1] as UIView)
            } else {
                self.addSubview(deck[i] as UIView)
            }
            loaded++
        }
        print("Number of cards loaded: \(loaded)")
        
    }
    var swiped: Int = 0
    func cardSwipedAway(card: UIView, direction: String) {
        let history: History = History()
        history.load()
        swiped++
        let attraction: Attaction = deck[0].attractionData
        deck.removeAtIndex(0)
        print("Card swiped away")
        if(history.checkIfExists(attraction.AttName)) == false {
            history.addAttraction(attraction)
            history.save()
        }
        if(direction == "right") {
            print("Saving to reading list array")
            toAttractionList.append(attraction)
            testAttractions.addAttraction(attraction)
            testAttractions.save()
        }
        // if all cards haven't been gone through, load another card into the deck
        if loaded < allCards.count {
            let newCard: SwipeCardsView = createSwipeCardsViewWithDataAtIndex(loaded)
            deck.append(newCard)
            //deck.append(allCards[loaded])
            loaded++
            self.insertSubview(deck[MAX_CARD_NUM-1] as UIView, belowSubview: deck[MAX_CARD_NUM-2] as UIView)
        }
        if(swiped == allCards.count) {
            print("Last card has been swiped")
            print("Number of swipe rights: \(toAttractionList.count)")
            //try to segue to the attraction list here.
            done = true
            self.window?.rootViewController?.childViewControllers[0].performSegueWithIdentifier("owlToList", sender: self)
        }
    }
    
    func swipeRight() {
        let cardView: SwipeCardsView = deck.first!
        cardView.overlayView.mode = OverlayViewMode.OverlayViewRight
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            cardView.overlayView.alpha = 1
        })
        cardSwipedAway(cardView, direction: "right")
    }
    
    func swipeLeft() {
        let cardView: SwipeCardsView = deck.first!
        cardView.overlayView.mode = OverlayViewMode.OverlayViewLeft
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            cardView.overlayView.alpha = 1
        })
        cardSwipedAway(cardView, direction: "left")
    }
    
    func createSwipeCardsViewWithDataAtIndex(index: Int) -> SwipeCardsView {
        let swipeCardsView: SwipeCardsView = SwipeCardsView(frame: CGRectMake((self.frame.size.width - CARD_WIDTH) / 2, (self.frame.size.height - CARD_HEIGHT) / 2.5, CARD_WIDTH, CARD_HEIGHT))
        swipeCardsView.attractionData = allCards[index].attractionData
        swipeCardsView.backgroundView.image = allCards[index].backgroundView.image
        swipeCardsView.label.attributedText = allCards[index].label.attributedText
        return swipeCardsView
    }
    
}