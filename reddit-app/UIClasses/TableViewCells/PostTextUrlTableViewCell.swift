//
//  PostTextUrlTableViewCell.swift
//  reddit-app
//
//  Created by Jackie Ramos on 04/04/2020.
//  Copyright © 2020 Jackie. All rights reserved.
//

import UIKit

class PostTextUrlTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func bind(_ vm: PostTextUrlCellViewModel) {
        var content: String = ""

        if vm.type == .text {
            content = vm.selftext
        } else if vm.type == .link {
            content = vm.url
        }
        
        self.titleLabel.text = vm.title
        self.contentLabel.text = content
    }
}
