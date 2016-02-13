//
//  ViewControllerSpec.swift
//  PhunwareTestSwift
//
//  Created by Gabriel Morales on 2/12/16.
//  Copyright © 2016 Phunware. All rights reserved.
//

import UIKit
import Quick
import Nimble
@testable import PhunwareTestSwift

class ViewControllerSpec: QuickSpec {
    override func spec() {
        var viewController: MasterCollectionViewController!
        
        beforeEach {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            viewController = storyboard.instantiateViewControllerWithIdentifier("Master") as! MasterCollectionViewController
            
            let _ = viewController.view
            let _ = viewController.loadView()
            let _ = viewController.viewDidLoad()
        }
    }
}
