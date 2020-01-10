//
//  SearchForMovieViewController.swift
//  MovieSearch
//
//  Created by Dionte Silmon on 1/10/20.
//  Copyright © 2020 Dionte Silmon. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class SearchForMovieViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    var searchedMovies: [[String: Any]] = [[String: Any]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Search"
        
        searchBar.placeholder = "Search for a movie"
        
    }
    

}

// MARK: - TableView Data Source Methods
extension SearchForMovieViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        return cell
    }
    
}

// MARK: - Search Bar Delegate Methods
extension SearchForMovieViewController: UISearchBarDelegate {
    
}
