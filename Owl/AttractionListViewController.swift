//
//  AttractionListViewController.swift
//  Owl
//
//  Created by Liuyuan Tan on 9/19/15.
//  Copyright © 2015 Mizzou Hackers. All rights reserved.
//

import UIKit

class AttractionListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
    
    @IBOutlet weak var attractionsListTableView: UITableView!
    
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
            print("test1")
            print(allAttractions!.count)
            return allAttractions!.count
        } else {
            print("test2")
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
            
            //cell.backgroundImage.image = UIImage(data: data!)
            
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedAttraction = allAttractions![indexPath.row]
        performSegueWithIdentifier("showAttraction", sender: self)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "showAttraction"){
            let destinationViewController = segue.destinationViewController as! AttractionViewController
            //destinationViewController.attractionWebURL =
            
            // let newsIndex = tableView.indexPathForSelectedRow()?.row
        }
        
    }
    
}
