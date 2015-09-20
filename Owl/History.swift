//
//  History.swift
//  Owl
//
//  Created by Liuyuan Tan on 9/19/15.
//  Copyright © 2015 Mizzou Hackers. All rights reserved.
//

import UIKit

class History: NSObject {
    var allAttractions: [viewAttraction] = []
    
    override init() {
        print("History initialized")
    }
    
    required init(coder decoder: NSCoder) {
        self.allAttractions = decoder.decodeObjectForKey("allAttactions") as! [viewAttraction]
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.allAttractions, forKey: "allAttactions")
    }
    
    func addAttraction(attraction: Attaction) {
        allAttractions.append(viewAttraction(title: attraction.AttName, url: attraction.webURL))
    }
    
    func save() {
        print("trying to save")
        let data = NSKeyedArchiver.archivedDataWithRootObject(self)
        print("data created, trying to write")
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "history")
        print("success")
    }
    
    func load() -> Bool {
        if let data = NSUserDefaults.standardUserDefaults().objectForKey("history") as? NSData {
            let unarchiver = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! History
            allAttractions = unarchiver.allAttractions
            print("History Loaded")
            return true
        }
        return false
    }
    
    //returns true if it exists
    func checkIfExists(attractionName: String) -> Bool {
        var i = 0
        for(i=0; i < allAttractions.count; i++) {
              print(attractionName)
            
            self.allAttractions = allAttractions as Array<viewAttraction>
            
            
            if (attractionName == allAttractions[i].title ) {
                //println("Article already read")
                return true
            }
        }
        return false
    }
}
