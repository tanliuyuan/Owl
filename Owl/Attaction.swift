//
//  Attaction.swift
//  Owl
//
//  Created by Hang Cui on 9/19/15.
//  Copyright © 2015 Mizzou Hackers. All rights reserved.
//

import UIKit

class Attaction: NSObject, NSCoding {

    var AttName: String = ""
    var webURL: String = ""
    var PhotoURL: String = ""
    //var section: String = ""
    
    init(AttName:String, webURL:String, PhotoURL:String) {
        self.AttName = AttName
        self.webURL = webURL
        self.PhotoURL = PhotoURL
    }
    
    func encodeWithCoder(coder: NSCoder) {
        //println("trying to encode in article data...")
        coder.encodeObject(AttName, forKey: "AttName")
        coder.encodeObject(PhotoURL, forKey: "PhotoURL")
        coder.encodeObject(webURL, forKey: "webURL")
        //coder.encodeObject(section, forKey: "section")
        //println("done")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        AttName = aDecoder.decodeObjectForKey("AttName") as! String
        PhotoURL = aDecoder.decodeObjectForKey("PhotoURL") as! String
        webURL = aDecoder.decodeObjectForKey("webURL") as! String
        //section = aDecoder.decodeObjectForKey("section") as! String
        print(AttName + " " + PhotoURL + " " + webURL + " ")
    }

}
