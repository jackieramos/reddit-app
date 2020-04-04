//
//  PostVideoTableViewCell.swift
//  reddit-app
//
//  Created by Jackie Ramos on 04/04/2020.
//  Copyright © 2020 Jackie. All rights reserved.
//

import UIKit
import AVFoundation

class PostVideoTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentVideoView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func bind(_ vm: PostVideoCellViewModel) {
        
        var videoUrl = ""
        
        self.titleLabel.text = vm.title
        
        if vm.type == .hostedVideo {
            if let validVideoUrl = vm.mediaURL {
                videoUrl = validVideoUrl
            }
        } else if vm.type == .richVideo {
            if let validVideoUrl = vm.mediaDomainURL {
                videoUrl = validVideoUrl
            }
        }

        let url = URL(string: videoUrl)
        
        if let validUrl = url {
            let player = AVPlayer(url: validUrl)
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.backgroundColor = UIColor.green.cgColor
            playerLayer.frame = self.contentVideoView.bounds
            self.contentVideoView.layer.addSublayer(playerLayer)
            player.play()
        }
    }
}
