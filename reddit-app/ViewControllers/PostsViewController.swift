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
    
    var posts: [Post] = []
    var after: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = self.subredditPath
        
        self.getPosts(self.subredditPath, after: "")
    }
    
    func getPosts(_ subredditPath: String, after: String) {
        APIManager.getPosts(subredditPath: subredditPath, after: after, completion: { response in
            switch response {
            case .success(let postsList):

                if self.after != postsList.after {
                    self.after = postsList.after

                    self.posts.append(contentsOf: postsList.list)
                    self.postsListVM = PostsListViewModel(posts: self.posts)
                    self.tableView.reloadData()
                }
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

            (cell as! PostImageTableViewCell).delegate = self
            (cell as! PostImageTableViewCell).bind(vm, indexPath: indexPath)
        default:
            break
        }
        
        if self.postsListVM.postsVM.count != 0 && self.after == nil {
            tableView.tableFooterView = UIView()
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.postUrlString = self.postsListVM.postsVM[indexPath.row].postPath
        self.performSegue(withIdentifier: "toPostDetailViewCotroller", sender: self)
    }
    
    ///Infinite pagination using after
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollViewHeight = scrollView.frame.size.height
        let scrollContentSizeHeight = scrollView.contentSize.height;
        let scrollOffset = scrollView.contentOffset.y;
        if (scrollOffset + scrollViewHeight > scrollContentSizeHeight - 200) {
            if let after = self.after {
                self.getPosts(self.subredditPath, after: after)
            }
        }
    }
}

extension PostsViewController: ScaledHeightImageDelegate {
    
    ///Reload cell after loading image for image-type post to layout properly
    ///
    /// - Parameters:
    ///   - indexPath: Cell indexPath to be reloaded
    func reloadCell(_ indexPath: IndexPath) {
        self.tableView.beginUpdates()
        self.tableView.reloadRows( at: [indexPath], with: .fade)
        self.tableView.endUpdates()
    }
}
