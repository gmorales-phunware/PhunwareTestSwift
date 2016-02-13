//
//  FeedAPI.swift
//  PhunwareTestSwift
//
//  Created by Gabriel Morales on 2/12/16.
//  Copyright © 2016 Phunware. All rights reserved.
//

import UIKit
import Alamofire

class FeedAPI: NSObject {
    
    class func sharedInstance() -> FeedAPI {
        struct Static {
            static var instance: FeedAPI?
            static var token: dispatch_once_t = 0
        }
        dispatch_once(&Static.token) { () -> Void in
            Static.instance = FeedAPI()
        }
        return Static.instance!
    }
}
