//
//  AttractionListViewController.swift
//  Owl
//
//  Created by Liuyuan Tan on 9/19/15.
//  Copyright © 2015 Mizzou Hackers. All rights reserved.
//

import UIKit

class AttractionListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var attractionListTableView: UITableViewCell!
    
    var attractionList = Attactions()
    var allAttractions: [Attaction]?
    var selectedAttraction: Attaction?
    
    /*// A set of constant and variable strings for making up the URL for article searching using NYT's API
    let articleSearchBaseUrl = "http://api.nytimes.com/svc/mostpopular/v2"
    let articleSearchResourceType = "mostviewed" // mostemailed | mostshared | mostviewed
    let articleSearchSections = "all-sections"
    let articlesSearchNumOfDays = 1 // 1 | 7 | 30
    let articleSearchReturnFormat = ".json"
    let articleSearchAPIKey = "b772e34fc2a53d05fe60d6c63d0c0e4c:9:71573042"*/
    
    var attractions: Attaction?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        /*let articleSearchUrl = articleSearchBaseUrl + "/" + articleSearchResourceType + "/" + articleSearchSections + "/" + "\(articlesSearchNumOfDays)" + articleSearchReturnFormat + "?" + "&API-Key=" + articleSearchAPIKey
        
        // load articles from the NYT API
        readingList.load(articleSearchUrl, loadCompletionHandler: {
            (nytArticles, errorString) -> Void in
            if let unwrappedErrorString = errorString {
                print(unwrappedErrorString)
            } else {
                
                print(self.readingList.articles.count)
                self.myTableView.reloadData()
                
            }
        })
        allArticles = testArticles?.getArticles()*/
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if allAttractions != nil {
            return allAttractions!.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("attractionListCell", forIndexPath: indexPath)
        if(allAttractions!.count > 0) {
            
            
            //cell.title?.text = readingList.articles[indexPath.row].title
            cell.textLabel?.text = allAttractions![indexPath.row].AttName
            cell.textLabel?.font = UIFont(name: cell.textLabel!.font.fontName, size: 18)
            //let url = NSURL(string: readingList.articles[indexPath.row].imageUrl)
            let url = NSURL(string: allAttractions![indexPath.row].PhotoURL)
            let data = NSData(contentsOfURL: url!)
            
            
            
            cell.backgroundImage.image = UIImage(data: data!)
            
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedArticle = allArticles![indexPath.row]
        performSegueWithIdentifier("showArticle", sender: self)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal , title: "Share", handler: { (action: UITableViewRowAction, indexPath: NSIndexPath) in
            
            let composer = TWTRComposer()
            
            composer.setText("Check out this awesome article!\n\n" + self.allArticles![indexPath.row].url + "\n\n#seaCow #articleTags? #whatever")
            composer.setImage(UIImage(named: "fabric"))
            
            composer.showWithCompletion { (result) -> Void in
                if (result == TWTRComposerResult.Cancelled) {
                    print("Tweet composition cancelled")
                }
                else {
                    print("Sending tweet!")
                }
            }
            
            self.myTableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            
            return
        })
        
        shareAction.backgroundColor = UIColor.blueColor()
        
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default , title: "Delete", handler: { (action: UITableViewRowAction, indexPath: NSIndexPath) in
            
            self.allArticles?.removeAtIndex(indexPath.row)
            self.testArticles?.removeArticle(indexPath.row)
            self.myTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            self.testArticles!.save()
            return
        })
        
        return [deleteAction, shareAction]
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "showArticle"){
            let destinationViewController = segue.destinationViewController as! ArticleViewController
            destinationViewController.article = selectedArticle
        }
        
    }
    
}
