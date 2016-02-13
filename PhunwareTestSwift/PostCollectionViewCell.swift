//
//  PostCollectionViewCell.swift
//  PhunwareTestSwift
//
//  Created by Gabriel Morales on 2/9/16.
//  Copyright © 2016 Phunware. All rights reserved.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    //    required init?(coder aDecoder: NSCoder) {
    //        super.init(coder: aDecoder)
    //    }
    
//    deinit {
//        postImageView = nil
//        postTitleLabel = nil
//        postDateLabel = nil
//        locationLabel = nil
//        descLabel = nil
//    }
}
