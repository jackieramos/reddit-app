//
//  ScaledHeightImageView.swift
//  reddit-app
//
//  Created by Jackie Ramos on 04/04/2020.
//  Copyright © 2020 Jackie. All rights reserved.
//

import UIKit

class ScaledHeightImageView: UIImageView {

    /// Resize imageView according to its image size/resolution
    override var intrinsicContentSize: CGSize {

        if let img = self.image {
            let imgWidth = img.size.width
            let imgHeight = img.size.height
            let viewWidth = self.frame.size.width

            let ratio = viewWidth/imgWidth
            let scaledHeight = imgHeight * ratio

            return CGSize(width: viewWidth, height: scaledHeight)
        }

        return CGSize(width: -1.0, height: -1.0)
    }
}
