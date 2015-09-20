//
//  viewAttraction.swift
//  Owl
//
//  Created by Liuyuan Tan on 9/19/15.
//  Copyright © 2015 Mizzou Hackers. All rights reserved.
//

import UIKit

class viewAttraction: NSObject, NSCoding {
    
    var title: String!
    var url: String!
    // MARK: NSCoding
    
    override init() {}
    
    required init(title: String, url: String) {
        self.title = title
        self.url = url
    }
    
    required init?(coder decoder: NSCoder) {
        self.title = decoder.decodeObjectForKey("title") as! String?
        self.url = decoder.decodeObjectForKey("url") as! String?
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.title, forKey: "title")
        coder.encodeObject(self.url, forKey: "url")
    }
    
    
    
}
