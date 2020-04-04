//
//  SubredditsListViewController.swift
//  reddit-app
//
//  Created by Jackie Ramos on 03/04/2020.
//  Copyright © 2020 Jackie. All rights reserved.
//

import UIKit
import Alamofire

class SubredditsListViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var subredditsListVM = SubredditsListViewModel(subreddits: [])

    var subreddits: [Subreddit] = []
    var subredditPath = ""
    var after: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.searchBar.delegate = self
        self.getSubreddits(after: "", limit: 10)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
        self.searchBar.resignFirstResponder()
    }
    
    func getSubreddits(after: String, limit: Int) {
        APIManager.getSubreddits(after: after, limit: limit, completion: { response in
            switch response {
            case .success(let subredditsList):

                if self.after != subredditsList.after {
                    self.after = subredditsList.after
                    
                    self.subreddits.append(contentsOf: subredditsList.list)
                    self.subredditsListVM = SubredditsListViewModel(subreddits: self.subreddits)

                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPostsViewController" {
            let postsListVC = segue.destination as! PostsViewController
            
            postsListVC.subredditPath = self.subredditPath
        }
    }
}

extension SubredditsListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return self.subredditsListVM.subredditsVM.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SubredditCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubredditCollectionViewCell", for: indexPath) as! SubredditCollectionViewCell

        cell.bind(self.subredditsListVM.subredditsVM[indexPath.row])

        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        self.subredditPath = self.subredditsListVM.subredditsVM[indexPath.row].subreddit.path
        self.performSegue(withIdentifier: "toPostsViewController", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (GlobalUtil.screenSize().width/2)-30, height: 243)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (kind == UICollectionView.elementKindSectionFooter) {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SubredditsListLoadingFooterView", for: indexPath)
            return footerView
        }
        fatalError()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        var footerHeight: CGFloat = 0.0
        
        if self.subredditsListVM.subredditsVM.count == 0 || self.after != nil {
            footerHeight = 50
        }

        return CGSize(width: GlobalUtil.screenSize().width, height: footerHeight)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollViewHeight = scrollView.frame.size.height
        let scrollContentSizeHeight = scrollView.contentSize.height;
        let scrollOffset = scrollView.contentOffset.y;
        if (scrollOffset + scrollViewHeight > scrollContentSizeHeight - 200) {
            if let after = self.after {
                self.getSubreddits(after: after, limit: 10)
            }
        }
    }
}

extension SubredditsListViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "SearchNavigationViewController") as! UINavigationController
        
        nav.modalPresentationStyle = .fullScreen
        nav.modalTransitionStyle = .crossDissolve
        
        self.present(nav, animated: false, completion: nil)
    }
}
