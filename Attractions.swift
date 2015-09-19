//
//  Attractions.swift
//  Owl
//
//  Created by Hang Cui on 9/19/15.
//  Copyright © 2015 Mizzou Hackers. All rights reserved.
//

import UIKit

class Attractions: NSObject {
    
    var AtractionName: String = ""
    var webURL: String = ""
    var anyAddition: String = ""
    var locationID: String = ""

    init(AtractionName:String, webURL:String, anyAddition:String, locationID: String) {
        self.AtractionName = AtractionName
        self.webURL = webURL
        self.anyAddition = anyAddition
        self.locationID = locationID
    }

}
