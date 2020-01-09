//
//  ViewController.swift
//  MovieSearch
//
//  Created by Dionte Silmon on 1/9/20.
//  Copyright © 2020 Dionte Silmon. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var movieTableView: UITableView!
    
    
    let apikey = "INSERT YOUR API KEY HERE"
    let baseURLForNowPlaying = "https://api.themoviedb.org/3/movie/now_playing"
    let baseURLImageString = "https://image.tmdb.org/t/p/w500"
    
    var movies: [[String: Any]] = [[String: Any]]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Now Playing"
        
        movieTableView.rowHeight = 100.0
        
        setQuery()
    }

    func setQuery() {
        
        let params: [String: String] = ["api_key": APIKEY, "language": "en-US", "page": "1"]
        
        fetchData(url: baseURLForNowPlaying, paramemters: params)
        
    }
    
    func fetchData(url: String, paramemters: [String: String]) {
        
        Alamofire.request(url, method: .get, parameters: paramemters).responseJSON {
            response in
            
            if let responseValue = response.result.value as! [String: Any]? {
                if let responseMovies = responseValue["results"] as! [[String: Any]]? {
                    self.movies = responseMovies
                    DispatchQueue.main.async {
                        self.movieTableView.reloadData()
                    }
                }
                
            }
        }
        
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)
        
        let eachMovie = self.movies[indexPath.row]
        
        cell.textLabel?.text = (eachMovie["title"] as? String) ?? ""
        
        return cell
        
    }
    
    
}
