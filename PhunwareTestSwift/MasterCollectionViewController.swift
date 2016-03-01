//
//  MasterCollectionViewController.swift
//  PhunwareTestSwift
//
//  Created by Gabriel Morales on 2/8/16.
//  Copyright © 2016 Phunware. All rights reserved.
//

import UIKit
import CoreSpotlight
import MobileCoreServices
import ReachabilitySwift
import Alamofire
import AlamofireImage
import STLocationRequest


private let reuseIdentifier = "Cell"

class MasterCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var responseArray: NSMutableArray?
    var objects = [StarWars]()
    var detailViewController = DetailViewController()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.preferredContentSize = (UI_USER_INTERFACE_IDIOM() == .Pad) ? CGSizeMake(320.00, 600.00) : CGSizeMake(CGRectGetWidth(self.collectionView!.bounds), CGRectGetHeight(self.collectionView!.bounds)/3)
        self.clearsSelectionOnViewWillAppear = (UI_USER_INTERFACE_IDIOM() == .Pad) ? false : true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem(title: " ", style: .Plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton
        checkInternet()
        loadFeed()
        if #available(iOS 9.0, *) { setupCoreSpotlight() }
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Location", style: .Plain, target: self, action: "showLocationRequest")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: .Default)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let cell = sender as? PostCollectionViewCell, indexPath = collectionView!.indexPathForCell(cell) {
                let selected:StarWars = self.objects[indexPath.row]
                let destination:DetailViewController = segue.destinationViewController as! DetailViewController
                destination.detailItem = selected
            }
            
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return objects.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PostCollectionViewCell
        let model:StarWars = self.objects[indexPath.row]
        cell.postTitleLabel?.text = model.title
        cell.postDateLabel?.text = model.convertToLocalTimeWithString(model.date)
        cell.locationLabel?.text = "\(model.locationLineOne) \(model.locationLineTwo)"
        cell.descLabel?.text = model.desc
        cell.postImageView.alpha = 0.5
        cell.postImageView.setImageWithUrl(model.imageURL, placeHolderImage: UIImage(named: "placeholder"))
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = CGRectGetWidth(self.collectionView!.bounds) / 2 - 3
        let height = CGRectGetHeight(self.collectionView!.bounds) / 3 - 22.333333
        let itemSize = CGSizeMake(width, height)
        let deviceSize = (UI_USER_INTERFACE_IDIOM() == .Pad) ? itemSize : CGSizeMake(CGRectGetWidth(self.collectionView!.bounds), CGRectGetHeight(self.collectionView!.bounds)/3)
        return deviceSize
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return (UI_USER_INTERFACE_IDIOM() == .Pad) ? UIEdgeInsetsMake(1, 1, 1, 1) : UIEdgeInsetsMake(1, 0, 1, 0)
    }
    
    // MARK: - Orientation
    @available(iOS, deprecated=8.0)
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        super.willRotateToInterfaceOrientation(toInterfaceOrientation, duration: duration)
        self.collectionView?.invalidateIntrinsicContentSize()
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        updateCollectionViewLayoutWithSize(size)
    }
    
    func updateCollectionViewLayoutWithSize(size: CGSize) {
        let width = CGRectGetWidth(UIScreen.mainScreen().bounds) / 2 - 3
        let height = CGRectGetHeight(UIScreen.mainScreen().bounds) / 3 - 22.333333
        let layout = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = (size.width < size.height) ? CGSizeMake(width, height) : CGSizeMake(width, height)
        layout.invalidateLayout()
    }
    
    // MARK: - CoreSpotlight
    func setupCoreSpotlight() {
        if #available(iOS 9.0, *) {
            let attributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
            attributeSet.title = "This is my Phunware Test app"
            attributeSet.contentDescription = "This is an example of the new iOS Dev Challenge"
            attributeSet.keywords = ["Phunware", "iOS", "Phun"]
            let imagePath = UIImage(named: "placeholder")!
            let imageData = UIImagePNGRepresentation(imagePath)
            attributeSet.thumbnailData = imageData
            
            let searchableItem = CSSearchableItem(uniqueIdentifier: "com.phunware", domainIdentifier: "devtest.example", attributeSet: attributeSet)
            
            CSSearchableIndex
                .defaultSearchableIndex()
                .indexSearchableItems([searchableItem]) { (error: NSError?) -> Void in
                    if let error = error {
                        self.showAlertWithTitle("Alert", message: error.localizedDescription)
                    }
            }
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    // MARK: - Helper Methods
    func loadFeed() {
        let hud = GMHudView(title: "Loading...", loading: true)
        hud.show()
        Alamofire.request(.GET, "https://raw.githubusercontent.com/phunware/services-interview-resources/master/feed.json") .responseJSON { response in // 1
            print(response.result)   // result of response serialization
            
            if (response.result.isSuccess) {
                if let JSON = response.result.value {
                    self.responseArray = JSON as? NSMutableArray
                    for responseDict in self.responseArray! {
                        let model = StarWars(modelDictionary: responseDict as! NSDictionary)
                        self.objects.append(model)
                    }
                    self.collectionView?.reloadData()
                    //                    self.sortFeed(self.objects)
                    if (UI_USER_INTERFACE_IDIOM() == .Pad) {
                        self.detailViewController.detailItem = self.objects.first
                    }
                    hud.completeAndDismissWithTitle("Loaded")
                    print("New object is \(self.objects.count)")
                }
            } else {
                self.showAlertWithTitle("Alert", message: (response.result.error?.localizedDescription)!)
            }
        }
    }
    
    func sortFeed(sorted: NSArray) {
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        self.objects = (sorted.sortedArrayUsingDescriptors([sortDescriptor]) as? [StarWars])!
        //        self.objects = (sorted.sortedArrayUsingDescriptors([sortDescriptor]) as? [StarWars])!
        self.collectionView!.reloadData()
        
    }
    
    func showAlertWithTitle(title: NSString, message: NSString) {
        let alert = UIAlertController(title: title as String, message: message as String, preferredStyle: .Alert)
        let cancel = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
        alert.addAction(cancel)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func checkInternet() {
        let reachability: Reachability
        do {
            reachability = try Reachability.reachabilityForInternetConnection()
        } catch {
            print("Unable to create Reachability")
            return
        }
        
        reachability.whenReachable = { reachability in
            dispatch_async(dispatch_get_main_queue()) {
                if reachability.isReachableViaWiFi() || reachability.isReachableViaWWAN() {
                    print("Reachabale")
                }
            }
        }
        reachability.whenUnreachable = { reachability in
            dispatch_async(dispatch_get_main_queue()) {
                [self .showAlertWithTitle("Alert", message: "No internet connection detected. Some functionality will be limited until a connection is made.")]
            }
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    // MARK: - Calendar
    func showLocationRequest(){
        self.showLocationRequestController(setTitle: "We need your location for some awesome features", setAllowButtonTitle: "Alright", setNotNowButtonTitle: "Not now", setMapViewAlphaValue: 0.7, setBackgroundViewColor: UIColor(red:0, green:0.56, blue:0.8, alpha:1))
    }
}
