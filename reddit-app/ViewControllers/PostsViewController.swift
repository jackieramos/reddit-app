//
//  PostsViewController.swift
//  reddit-app
//
//  Created by Jackie Ramos on 04/04/2020.
//  Copyright © 2020 Jackie. All rights reserved.
//

import UIKit

class PostsViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var postsListVM = PostsListViewModel(posts: [])
    var subredditPath: String!
    
    var postUrlString: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        self.getPosts(self.subredditPath)
    }
    
    func getPosts(_ subredditPath: String) {
        APIManager.getPosts(subredditPath: subredditPath, completion: { response in
            switch response {
            case .success(let postsList):
                self.postsListVM = PostsListViewModel(posts: postsList.list)
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPostDetailViewCotroller" {
            let postDetailVC = segue.destination as! PostDetailViewController
            postDetailVC.postUrlString = self.postUrlString
        }
    }
}

extension PostsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.postsListVM.postsVM.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        let postVM = self.postsListVM.postsVM[indexPath.row]
        
        switch postVM {
        case let vm as PostTextUrlCellViewModel:
            cell = tableView.dequeueReusableCell(withIdentifier: "PostTextUrlTableViewCell", for: indexPath) as! PostTextUrlTableViewCell
            (cell as! PostTextUrlTableViewCell).bind(vm)
        case let vm as PostImageCellViewModel:
            cell = tableView.dequeueReusableCell(withIdentifier: "PostImageTableViewCell", for: indexPath) as! PostImageTableViewCell
            (cell as! PostImageTableViewCell).bind(vm)
        case let vm as PostVideoCellViewModel:
            cell = tableView.dequeueReusableCell(withIdentifier: "PostVideoTableViewCell", for: indexPath) as! PostVideoTableViewCell
            (cell as! PostVideoTableViewCell).bind(vm)
        default:
            break
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.postUrlString = self.postsListVM.postsVM[indexPath.row].postPath
        self.performSegue(withIdentifier: "toPostDetailViewCotroller", sender: self)
    }
}
