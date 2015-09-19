//
//  Attaction.swift
//  Owl
//
//  Created by Hang Cui on 9/19/15.
//  Copyright © 2015 Mizzou Hackers. All rights reserved.
//

import UIKit

class Attaction: NSObject {

    var AttName: String = ""
    var webURL: String = ""
    var PhotoURL: String = ""
    
    init(AttName:String, webURL:String, PhotoURL:String) {
        self.AttName = AttName
        self.webURL = webURL
        self.PhotoURL = PhotoURL
    }
}
