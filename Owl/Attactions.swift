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
    func load(fromURLString: String, completionHandler: (Attactions, String?) -> Void) {
        newAtt = [Attaction]()
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
        var jsonError: NSError
        do {
            let jsonResult = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
            if (jsonResult!.count > 0)
            {
                //let newAttaction = Attaction(AttName: xxx as String, webURL: xxx as String, PhotoURL: xxx as String)
                //newAtt.append(newAttaction)
            }
            dispatch_async(dispatch_get_main_queue(), {
                completionHandler(self, nil)
            })
            
        } catch _ {
            print ("xcode7 sucks")
        }
    }
    
}
