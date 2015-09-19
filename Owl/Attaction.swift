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
    
    init(AttName:String, webURL:String, PhotoURL:String) {
        self.AttName = AttName
        self.webURL = webURL
        self.PhotoURL = PhotoURL
    }
    
    required init?(coder decoder: NSCoder) {
        self.AttName = decoder.decodeObjectForKey("AttName") as! String
        self.webURL = decoder.decodeObjectForKey("webURL") as! String
        self.PhotoURL = decoder.decodeObjectForKey("PhotoURL") as! String
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.AttName, forKey: "AttName")
        coder.encodeObject(self.webURL, forKey: "webURL")
        coder.encodeObject(self.PhotoURL, forKey: "PhotoURL")
    }
}
