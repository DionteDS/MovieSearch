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
    var row = 0
    
    let baseSearchURL = "https://api.themoviedb.org/3/search/movie"
    let baseImageURL = "https://image.tmdb.org/t/p/w500"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Search"
        
        searchBar.placeholder = "Search for a movie"
        
        let nib = UINib(nibName: "SearchMovieTableViewCell", bundle: nil)
        
        searchTableView.register(nib, forCellReuseIdentifier: "searchedMovieCell")
        
        searchTableView.rowHeight = 100.0
        
    }
    
    func setSearchQuery(movieSearch: String) {
        
        let params: [String: String] = ["api_key": APIKEY, "query": movieSearch, "language": "en-US", "page": "1"]
        
        fetchData(url: baseSearchURL, parameters: params)
    }
    
    func fetchData(url: String, parameters: [String: String]) {
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            
            if let responseValue = response.result.value as! [String: Any]? {
                if let responseMovies = responseValue["results"] as! [[String: Any]]? {
                    self.searchedMovies = responseMovies
                    DispatchQueue.main.async {
                        self.searchTableView.reloadData()
                    }
                }
            }
        }
        
    }
    

}

// MARK: - TableView Data Source Methods
extension SearchForMovieViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchedMovieCell", for: indexPath) as! SearchMovieTableViewCell
        
        if searchedMovies.count > 0 {
            
            let eachMovie = self.searchedMovies[indexPath.row]
            
            cell.movieTitleLabel.text = (eachMovie["title"] as? String) ?? ""
            cell.movieReleaseDate.text = (eachMovie["release_date"] as? String) ?? ""
            
            if let imageURL = eachMovie["poster_path"] as? String {
                Alamofire.request(baseImageURL + imageURL).responseImage { (response) in
                    if let image = response.result.value {
                        DispatchQueue.main.async {
                            cell.searchMovieImage.image = image
                        }
                    }
                }
            }
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let indexPath = tableView.indexPathForSelectedRow?.row {
            row = indexPath
        }
        
        performSegue(withIdentifier: "searchInfoVC", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    // Pass data over to get the info for the selected movie cell
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "searchInfoVC" {
            let controller = segue.destination as! SearchMovieInfoViewController
            
            let eachMovie = self.searchedMovies[row]
            
            controller.mTitle = eachMovie["title"] as? String
            controller.movieImageURL = eachMovie["poster_path"] as? String
            controller.summary = eachMovie["overview"] as? String
        }
        
    }
    
}

// MARK: - Search Bar Delegate Methods
extension SearchForMovieViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        setSearchQuery(movieSearch: searchBar.text!)
        
        DispatchQueue.main.async {
            searchBar.resignFirstResponder()
        }
    }
    
}
