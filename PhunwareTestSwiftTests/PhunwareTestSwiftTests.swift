//
//  PhunwareTestSwiftTests.swift
//  PhunwareTestSwiftTests
//
//  Created by Gabriel Morales on 2/12/16.
//  Copyright © 2016 Phunware. All rights reserved.
//

import XCTest
@testable import PhunwareTestSwift

class PhunwareTestSwiftTests: XCTestCase {
    var vc:MasterCollectionViewController = MasterCollectionViewController()
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.vc = storyboard.instantiateViewControllerWithIdentifier("Master") as! MasterCollectionViewController
        self.vc.loadView()
        self.vc.viewDidLoad()
        self.vc.collectionView?.reloadData()
        
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    // MARK: - Tests
    
    func testViewLoads() {
        XCTAssertNotNil(self.vc.view, "View did not load")
        
    }
    
    func testConformsToUICollectionViewDataSource() {
        XCTAssertTrue(self.vc.conformsToProtocol(UICollectionViewDataSource), "View does not conform to collection data source")
    }
    
    func testConformsToUiCollectionViewDelegate() {
        XCTAssertTrue(self.vc.conformsToProtocol(UICollectionViewDelegate), "View does not conform to collection delegate")
    }
    
    func testConnectedToDelegate() {
        XCTAssertTrue((self.vc.collectionView?.delegate != nil), "Collectionview delegate cannot be nil")
    }
    
    func testCollectionViewNumberOfItemsInSection() {
        let expectedItems:Int = self.vc.objects.count
        XCTAssertTrue(self.vc .collectionView(self.vc.collectionView!, numberOfItemsInSection: 0)==expectedItems, "COllection does not contain 10 items")
    }
}
