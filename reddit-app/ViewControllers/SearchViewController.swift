//
//  SearchViewController.swift
//  reddit-app
//
//  Created by Jackie Ramos on 04/04/2020.
//  Copyright © 2020 Jackie. All rights reserved.
//

import UIKit
import Alamofire

class SearchViewController: BaseViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var subredditsListVM = SubredditsListViewModel(subreddits: [])
    
    var subredditPath = ""

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
        self.searchBar.becomeFirstResponder()
    }

    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func searchSubreddit(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, query.trimmingCharacters(in: .whitespaces) != "" else {
            return
        }

        APIManager.searchSubreddit(query: query, completion: { response in
            switch response {
            case .success(let subredditsList):
                self.subredditsListVM = SubredditsListViewModel(subreddits: subredditsList.list)
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchToPostsViewController" {
            let postsVC = segue.destination as! PostsViewController

            postsVC.subredditPath = self.subredditPath
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.subredditsListVM.subredditsVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchSubredditTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SearchSubredditTableViewCell", for: indexPath) as! SearchSubredditTableViewCell
        
        cell.bind(self.subredditsListVM.subredditsVM[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.subredditPath = self.subredditsListVM.subredditsVM[indexPath.row].subreddit.path
        self.performSegue(withIdentifier: "searchToPostsViewController", sender: self)
    }
}

extension SearchViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.searchSubreddit(_:)), object: searchBar)
        perform(#selector(self.searchSubreddit(_:)), with: searchBar, afterDelay: 0.75)
    }
}
