//
//  DetailViewController.swift
//  PhunwareTestSwift
//
//  Created by Gabriel Morales on 2/8/16.
//  Copyright © 2016 Phunware. All rights reserved.
//

import UIKit
import Social
import MessageUI
import Accounts

class DetailViewController: UIViewController, UIScrollViewDelegate, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var dateLabel: UILabel! {
        didSet {
            dateLabel.textColor = .whiteColor()
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var postTextView: UITextView!
    @IBOutlet weak var postImageView: UIImageView!
    
    var titleNavLabelVerticalConstraint:NSLayoutConstraint?
    var titleNavLabel:UILabel?
    
    var detailItem: StarWars? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        loadViews()
        if let detail = self.detailItem {
            titleLabel?.text = detail.title
            dateLabel?.text = detail.convertToLocalTimeWithString(detail.date)
            postTextView?.text = detail.desc
            postImageView?.setImageWithUrl(detail.imageURL, placeHolderImage: UIImage(named: "placeholder"))
        }
        
        if let phone = self.detailItem?.phone {
            phoneLabel?.text = "\(phone)"
        } else {
            phoneLabel?.text = "No Phone number available"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        hideNavBar()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - ScrollView Delegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if (scrollView.contentOffset.y <= 20) {
            UIView.animateWithDuration(0.3, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: .CurveEaseInOut, animations: { () -> Void in
                self.hideNavBar()
                }, completion: nil)
            return
        } else {
            UIView.animateWithDuration(0.3, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: .CurveEaseInOut, animations: { () -> Void in
                self.titleOffset(scrollView)
                }, completion: nil)
        }
    }
    
    // MARK: - Helper Methods
    func loadViews() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: "OnShare:")
        
        //Custom view to hold title label
        if let navBar = navigationController {
            let customNavView = UIView.init(frame: CGRectMake(0, 0, CGRectGetWidth(navBar.navigationBar.bounds), CGRectGetHeight(navBar.navigationBar.bounds)))
            customNavView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            customNavView.clipsToBounds = true
            customNavView.sizeToFit()
            
            //Navbar title label
            titleNavLabel = UILabel(frame: customNavView.bounds)
            titleNavLabel!.translatesAutoresizingMaskIntoConstraints = false
            titleNavLabel!.setContentHuggingPriority(UILayoutPriorityRequired, forAxis: .Vertical)
            titleNavLabel!.clipsToBounds = true
            titleNavLabel!.textAlignment = .Center
            titleNavLabel!.font = UIFont(name: "Avenir-Book", size: 18)
            titleNavLabel!.textColor = .whiteColor()
            titleNavLabel!.text = self.detailItem?.title.uppercaseString
            customNavView.addSubview(titleNavLabel!)
            
            self.navigationItem.titleView = customNavView
            
            //Layouts
            titleNavLabelVerticalConstraint = NSLayoutConstraint(item: titleNavLabel!, attribute: .Top, relatedBy: .Equal, toItem: customNavView, attribute: .Bottom, multiplier: 1, constant: 0)
            customNavView.addConstraint(titleNavLabelVerticalConstraint!)
            
            let titleNavLabelLeftConstraint = NSLayoutConstraint(item: titleNavLabel!, attribute: .Leading, relatedBy: .Equal, toItem: customNavView, attribute: .Leading, multiplier: 1, constant: 0)
            customNavView.addConstraint(titleNavLabelLeftConstraint)
            
            let titleNavLabelRightConstraint = NSLayoutConstraint(item: titleNavLabel!, attribute: .Trailing, relatedBy: .Equal, toItem: customNavView, attribute: .Trailing, multiplier: 1, constant: 0)
            customNavView.addConstraint(titleNavLabelRightConstraint)
            
            let titleNavLabelHeightConstraint = NSLayoutConstraint(item: titleNavLabel!, attribute: .Height, relatedBy: .Equal, toItem: customNavView, attribute: .Height, multiplier: 1, constant: -10)
            customNavView.addConstraint(titleNavLabelHeightConstraint)
        }
    }
    
    func hideNavBar() {
        if let navBar = navigationController {
            navBar.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
            navBar.navigationBar.shadowImage = UIImage()
            navBar.navigationBar.translucent = true
            navBar.navigationBar.backgroundColor = .clearColor()
            navBar.view.backgroundColor = .clearColor()
            navBar.navigationBar.alpha = 1.0
        }
    }
    
    func titleOffset(scrollView: UIScrollView) {
        if let navBar = navigationController {
            let offset:CGFloat = (scrollView.contentOffset.y / (scrollView.contentSize.height - self.view.frame.height) + 0.22)
            navigationController?.navigationBar.alpha = offset
            navBar.navigationBar.setBackgroundImage(nil, forBarMetrics: .Default)
            let titleLabelHeight:CGFloat = CGRectGetHeight(titleNavLabel!.bounds)
            let titleViewHeight:CGFloat = CGRectGetHeight(self.navigationItem.titleView!.bounds)
            let postTitleRect:CGRect = titleLabel.convertRect(titleLabel.bounds, toView: self.view)
            titleNavLabelVerticalConstraint?.constant = min(0.0, max(CGRectGetMinY(postTitleRect) * 1.0 - 64, -0.5 * (titleViewHeight + titleLabelHeight)))
        }
    }
    
    // MARK: - Actions
    func OnShare(sender: AnyObject) {
        var items = [AnyObject]()
        if ((self.postImageView!.image) != nil) {
            items = [self, postImageView.image!, ""]
        } else {
            items = [self, self.detailItem!.title]
        }
        
        let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        activityViewController.excludedActivityTypes = [
            UIActivityTypeAssignToContact, UIActivityTypePostToTencentWeibo, UIActivityTypePostToWeibo, UIActivityTypeSaveToCameraRoll, UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAirDrop]
        
        let completionBlock: UIActivityViewControllerCompletionWithItemsHandler = {(activityType: String?, completed: Bool?, returnedItems: [AnyObject]?, activityError: NSError?) -> Void in
            if completed != nil {
                print("Completed")
            }
        }
        activityViewController.completionWithItemsHandler = completionBlock
        
        if UI_USER_INTERFACE_IDIOM() == .Pad {
            activityViewController.popoverPresentationController!.barButtonItem = self.navigationItem.rightBarButtonItem;
        }
        
        self.presentViewController(activityViewController, animated: true, completion: { () -> Void in
            UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: true)
            self.navigationController?.navigationBar.tintColor = .whiteColor()
        })
    }
    
    func activityViewController(activityViewController: UIActivityViewController, itemForActivityType activityType: String) -> AnyObject? {
        let postTitle = String(format:"Check out %@", self.detailItem!.title)
        let postDesc = "\(self.detailItem!.desc)"
        
        if activityType == UIActivityTypeMail {
            //            activityViewController.setValue(postTitle, forKey: "subject")
            let body:NSMutableString = NSMutableString()
            body.appendString("<html><body><h2>")
            body.appendString(self.detailItem!.title)
            body.appendString("</h2><p>")
            body.appendString("Location: \(self.detailItem!.locationLineOne) \(self.detailItem!.locationLineTwo)")
            body.appendString("</p><p>")
            body.appendString(self.detailItem!.desc)
            body.appendString("</p></body></html>")
            return body
        } else if activityType == UIActivityTypePostToTwitter {
            //            let maxChars = ((self.postImageView?.image) != nil) ? 116 : 140
            return postTitle
        } else if (activityType == UIActivityTypePostToFacebook || activityType == UIActivityTypeMessage) {
            return "\(postTitle).\n\(postDesc)"
        } else {
            return nil
        }
    }
    
    func activityViewController(activityViewController: UIActivityViewController, subjectForActivityType activityType: String?) -> String {
        let postTitle = String(format:"Check out %@", self.detailItem!.title)
        if activityType == UIActivityTypeMail {
            return postTitle
        } else {
            return ""
        }
    }
    
    
}

