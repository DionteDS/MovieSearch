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
    
    let apikey = "INSERT YOUR API KEY HERE"
    let baseURLForNowPlaying = "https://api.themoviedb.org/3/movie/now_playing"
    let baseURLImageString = "https://image.tmdb.org/t/p/w500"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                    print(responseMovies)
                    
                }
                
            }
        }
        
    }

}

