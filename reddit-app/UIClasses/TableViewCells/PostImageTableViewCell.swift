//
//  PostImageTableViewCell.swift
//  reddit-app
//
//  Created by Jackie Ramos on 04/04/2020.
//  Copyright © 2020 Jackie. All rights reserved.
//

import UIKit

protocol ScaledHeightImageDelegate: class {
    func reloadCell(_ indexPath: IndexPath)
}

class PostImageTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentImageView: ScaledHeightImageView!
    
    weak var delegate: ScaledHeightImageDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    func bind(_ vm: PostImageCellViewModel, indexPath: IndexPath) {
        self.titleLabel.text = vm.title
        self.contentImageView.loadImagesUsingCacheWithUrlString(urlString: vm.url) {
            self.delegate?.reloadCell(indexPath)
        }
    }
}
