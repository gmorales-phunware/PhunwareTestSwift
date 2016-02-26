//
//  StarWars.swift
//  PhunwareTestSwift
//
//  Created by Gabriel Morales on 2/9/16.
//  Copyright © 2016 Phunware. All rights reserved.
//

import UIKit

class StarWars {
    var title: String
    var date: String
    var desc: String
    var locationLineOne: String
    var locationLineTwo: String
    var timeStamp: String
    var phone: String?
    var imageURL: NSURL
    //    
    init(modelDictionary: NSDictionary) {
        title = modelDictionary["title"] as! String
        desc = modelDictionary["description"] as! String
        locationLineOne = modelDictionary["locationline1"] as! String
        locationLineTwo = modelDictionary["locationline2"] as! String
        phone = modelDictionary["phone"] as? String
        timeStamp = modelDictionary["timestamp"] as! String
        date = modelDictionary["date"] as! String
        
        let urlString = String(format: "%@", (modelDictionary["image"] as? String)!)
        imageURL = NSURL(string: urlString)!
        
    }
    
    func getLocalTimeFromString(string: String) -> NSDate {
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let timeZone: NSTimeZone = NSTimeZone.localTimeZone()
        dateFormatter.timeZone = timeZone
        return dateFormatter.dateFromString(string)!
    }
    
    func convertToLocalTimeWithString(string: String) -> String {
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone.systemTimeZone()
        dateFormatter.dateFormat = "MMM d,yyyy"
        let dateString: String = dateFormatter.stringFromDate(self.getLocalTimeFromString(string))
        dateFormatter.dateFormat = "h:mma"
        let timeString: String = dateFormatter.stringFromDate(self.getLocalTimeFromString(string))
        return "\(dateString) at \(timeString)"
    }
}
