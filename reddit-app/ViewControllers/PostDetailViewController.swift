//
//  PostDetailViewController.swift
//  reddit-app
//
//  Created by Jackie Ramos on 04/04/2020.
//  Copyright © 2020 Jackie. All rights reserved.
//

import UIKit
import WebKit

class PostDetailViewController: BaseViewController {

    @IBOutlet weak var webView: WKWebView!
    
    var postUrlString: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: postUrlString)
        
        guard let validUrl = url else {
            return
        }
        
        let request = URLRequest(url: validUrl)

//        self.webView.navigationDelegate = self
        self.webView.load(request)
    }
}

//extension PostDetailViewController: WKNavigationDelegate {
//    
//}
