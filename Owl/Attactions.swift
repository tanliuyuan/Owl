//
//  Attactions.swift
//  Owl
//
//  Created by Hang Cui on 9/19/15.
//  Copyright © 2015 Mizzou Hackers. All rights reserved.
//

import UIKit

class Attactions: NSObject {
    
    var newAtt = [Attaction]()
    var history: History = History()

    func load(fromURLString: String, completionHandler: (Attactions, String?) -> Void) {
        newAtt = [Attaction]()
        history.load()
        if let url = NSURL(string: fromURLString) {
            let urlRequest = NSMutableURLRequest(URL: url)
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithRequest(urlRequest, completionHandler: {
                (data, response, error) -> Void in
                if error != nil {
                    dispatch_async(dispatch_get_main_queue(), {
                        completionHandler(self, error!.localizedDescription)
                    })
                }
                else {
                    self.parse(data!, completionHandler: completionHandler)
                }
            })
            task.resume()
        }
        else {
            dispatch_async(dispatch_get_main_queue(), {
                completionHandler(self, "Invalid URL")
            })
        }
    }
    
    func parse(jsonData: NSData, completionHandler: (Attactions, String?) -> Void) {
        do {
            let jsonResult = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
            if (jsonResult!.count > 0) {
                if let attractions = jsonResult?["data"] as? NSArray {
                    for attraction in attractions {
                        if let locationID = attraction["location_id"] as? NSString {
                            if let locationName = attraction["name"] as? NSString {
                                if let webURL = attraction["web_url"] as? NSString {
                                    
                                    
                                    let jsonUrl = "https://api.tripadvisor.com/api/partner/2.0/location/" + "\(locationID)" + "/photos?key=4695B5894B33493BA4A0389F61843655"
                                    
                                    let session = NSURLSession.sharedSession()
                                    let shotsUrl = NSURL(string: jsonUrl)
                                    
                                    let taskPhoto = session.dataTaskWithURL(shotsUrl!) {
                                        (data, response, error) -> Void in
                                        
                                        do {
                                            let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
                                            if let photos = jsonData["data"] as? NSArray {
                                                if (photos.count > 0) {
                                                    // print("CHeck1")
                                                    if let singlePhoto = photos[0] as? NSDictionary {
                                                        if let singlePhotoLarge = singlePhoto["images"] as? NSDictionary {
                                                            if let iDontKnowWhatIShouldCouldThis = singlePhotoLarge["large"] as? NSDictionary {
                                                                
                                                                if let photoURL = iDontKnowWhatIShouldCouldThis["url"] as? String {
                                                                    print(locationName)
                                                                    print(webURL)
                                                                    
                                                                    print(photoURL)
                                                                    
                                                                    let newAttaction = Attaction(AttName: locationName as String, webURL: webURL as String, PhotoURL: photoURL as String)
                                                                    self.newAtt.append(newAttaction)
                                                                }
                                                            }
                                                            
                                                        }
                                                    }
                                                }
                                            }
                                        } catch _ {
                                            print("Error find location photo")
                                        }
                                    }
                                    taskPhoto.resume()
                                }
                            }
                        }
                    }
                }
            }
            dispatch_async(dispatch_get_main_queue(), {
                completionHandler(self, nil)
            })
            
        } catch _ {
            print ("xcode7 sucks")
        }
    }
    
}
