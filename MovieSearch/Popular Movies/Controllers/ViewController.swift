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
    var row = 0
    
//    let APIKEY = "Place API Key here"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Now Playing"
        navigationController?.navigationBar.backgroundColor = UIColor(red: 60/255, green: 78/255, blue: 106/255, alpha: 1.0)
        
        let nib = UINib(nibName: "CustomMovieTableViewCell", bundle: nil)
        
        movieTableView.register(nib, forCellReuseIdentifier: "movieCell")
        movieTableView.rowHeight = 100.0
        
        setQuery()
    }

    //MARK: - Networking
    
    // Query the data
    func setQuery() {
        
        let params: [String: String] = ["api_key": APIKEY, "language": "en-US", "page": "1"]
        
        fetchData(url: baseURLForNowPlaying, paramemters: params)
        
    }
    
    // Parse the data
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

//MARK: - TableView Data Source Methods

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! CustomMovieTableViewCell
        
        if movies.count > 0 {
            
            // Set up each movie cell with its title and release date
            let eachMovie = self.movies[indexPath.row]
            
            cell.movieTitle.text = (eachMovie["title"] as? String) ?? ""
            cell.movieReleaseDate.text = (eachMovie["release_date"] as? String) ?? ""
            
            
            // Also set the movie poster image for each movie cell
            if let imageURL = eachMovie["poster_path"] as? String {
                Alamofire.request(baseURLImageString + imageURL).responseImage { (response) in
                    if let image = response.result.value {
                        let cornerImage = image.af_imageRounded(withCornerRadius: 25.0)
                        DispatchQueue.main.async {
                            cell.movieImage.image = cornerImage
                        }
                    }
                }
            }
            
        }
        
        return cell
        
    }
    
    // When selecting a cell set the row to the selected indexPath.row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let indexPath = tableView.indexPathForSelectedRow?.row {
            row = indexPath
        }
        
        performSegue(withIdentifier: "infoVC", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    // Prepare data to be send over to InfoViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "infoVC" {
            let controller = segue.destination as! InfoViewController
            
            let movie = movies[row]
            
            controller.mTitle = movie["title"] as? String
            controller.summary = movie["overview"] as? String
            controller.imageSelectedURL = movie["poster_path"] as? String
            
        }
        
    }
    
    
}
