//
//  SubredditCollectionViewCell.swift
//  reddit-app
//
//  Created by Jackie Ramos on 03/04/2020.
//  Copyright © 2020 Jackie. All rights reserved.
//

import UIKit

class SubredditCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var membersCountLabel: UILabel!

    func bind(_ subredditVM: SubredditCellViewModel) {
        
        self.bannerImageView.loadImagesUsingCacheWithUrlString(urlString: subredditVM.bannerImageURL)
        self.iconView.loadImagesUsingCacheWithUrlString(urlString: subredditVM.iconImageURL)
        self.titleLabel.text = subredditVM.title
        self.descriptionLabel.text = subredditVM.description
        self.membersCountLabel.text = subredditVM.membersCount
    }
}
