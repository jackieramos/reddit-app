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
    var subredditPath = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        self.searchBar.delegate = self
        self.getSubreddits()
    }
    
    func getSubreddits() {
        APIManager.getSubreddits(completion: { response in
            switch response {
            case .success(let subredditsList):
                self.subredditsListVM = SubredditsListViewModel(subreddits: subredditsList.list)
                self.collectionView.reloadData()
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (GlobalUtil.screenSize().width/2)-30, height: 243)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        self.subredditPath = self.subredditsListVM.subredditsVM[indexPath.row].subreddit.path
        self.performSegue(withIdentifier: "toPostsViewController", sender: self)
    }
}

extension SubredditsListViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        
        self.modalPresentationStyle = .fullScreen
        self.modalTransitionStyle = .crossDissolve
        
        self.present(vc, animated: true, completion: nil)
    }
}
