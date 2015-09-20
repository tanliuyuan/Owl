//
//  AttractionList.swift
//  Owl
//
//  Created by Liuyuan Tan on 9/19/15.
//  Copyright © 2015 Mizzou Hackers. All rights reserved.
//

import UIKit

class AttractionList: NSObject, NSCoding {
    var attractions: [Attaction]! = []
    override init() {
        print("Initalizing Reading List")
    }
    
    func addAttraction(attraction: Attaction) {
        print("Adding attraction")
        attractions.append(attraction)
        
    }
    
    func removeAttraction(index: Int) {
        print("Removing attraction")
        attractions.removeAtIndex(index)
    }
    
    func getAttractions() -> [Attaction] {
        print("Returning list")
        return attractions!
    }
    
    
    // MARK: NSCoding
    func encodeWithCoder(coder: NSCoder) {
        print("trying to encode articles, value: ")
        print(attractions)
        coder.encodeObject(attractions, forKey: "attraction")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        let decoder: AnyObject? = aDecoder.decodeObjectForKey("attraction")
        print("trying to load reading list in init...")
        if (decoder != nil) {
            print("reading list loaded")
            //test = (temp  as! ReadingList).test
            attractions = decoder as! [Attaction]
        } else {
            print("failed")
        }
    }
    
    func save() {
        print("trying to save")
        let data = NSKeyedArchiver.archivedDataWithRootObject(self)
        print("data created, trying to write")
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "attractionList")
        print("success")
    }
    
    func load() -> Bool {
        if let data = NSUserDefaults.standardUserDefaults().objectForKey("attractionList") as? NSData {
            let unarchiver = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! AttractionList
            attractions = unarchiver.attractions
            return true
        }
        return false
    }
}
