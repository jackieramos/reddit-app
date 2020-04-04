//
//  SearchSubredditTableViewCell.swift
//  reddit-app
//
//  Created by Jackie Ramos on 04/04/2020.
//  Copyright © 2020 Jackie. All rights reserved.
//

import UIKit

class SearchSubredditTableViewCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var memberCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func bind(_ vm: SubredditCellViewModel) {
       
        if let validUrl = vm.iconImageURL {
            self.iconImageView.loadImagesUsingCacheWithUrlString(urlString: validUrl)
        }

        self.titleLabel.text = vm.title
        self.memberCountLabel.text = vm.membersCount
    }
}
