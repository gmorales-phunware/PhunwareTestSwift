//
//  StarWars.swift
//  PhunwareTestSwift
//
//  Created by Gabriel Morales on 2/9/16.
//  Copyright © 2016 Phunware. All rights reserved.
//

import UIKit

class StarWars {
    var title: String?
    var date: String?
    var desc: String?
    var locationLineOne: String?
    var locationLineTwo: String?
    var timeStamp: String?
    var phone: String?
    var imageURL: NSURL?
    //    
    //    class func fetchStarWarsData() -> [StarWars] {
    //        var starWars = [StarWars]()
    //        
    //        //        var starWarsJSON = JSONValue(data)
    //        return starWars
    //    }
    
    
    //    _title = dict[@"title"];
    //    _desc = dict[@"description"];
    //    _locationLineOne = dict[@"locationline1"];
    //    _locationLineTwo = dict[@"locationline2"];
    //    _phone = dict[@"phone"];
    //    _timeStamp = dict[@"timestamp"];
    //    _date = dict[@"date"];
    //    _imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", dict[@"image"]]];
    init(modelDictionary: NSDictionary) {
        title = modelDictionary["title"] as? String
        desc = modelDictionary["description"] as? String
        locationLineOne = modelDictionary["locationline1"] as? String
        locationLineTwo = modelDictionary["locationline2"] as? String
        phone = modelDictionary["phone"] as? String
        timeStamp = modelDictionary["timestamp"] as? String
        date = modelDictionary["date"] as? String
        
        let urlString = String(format: "%@", (modelDictionary["image"] as? String)!)
        imageURL = NSURL(string: urlString)
        
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
