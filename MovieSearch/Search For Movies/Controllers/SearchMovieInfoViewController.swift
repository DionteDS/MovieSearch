//
//  SearchMovieInfoViewController.swift
//  MovieSearch
//
//  Created by Dionte Silmon on 1/11/20.
//  Copyright © 2020 Dionte Silmon. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class SearchMovieInfoViewController: UIViewController {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var summaryTextLabel: UITextView!
    
    var mTitle: String?
    var movieImageURL: String?
    var summary: String?
    let baseImageURL = "https://image.tmdb.org/t/p/w500"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = mTitle
        
        if let movieSummary = summary {
            self.summaryTextLabel.text = movieSummary
        }
        
        getMovieImage()
        
    }
    
    
    // Set the image of the movie poster
    func getMovieImage() {
        
        if let imageURL = movieImageURL {
            Alamofire.request(baseImageURL + imageURL).responseImage { (response) in
                
                if let image = response.result.value {
                    let width = (self.view.bounds.width / 2) - 5
                    let height = width
                    let size = CGSize(width: width, height: height)
                    let scaledImage = image.af_imageScaled(to: size)
                    DispatchQueue.main.async {
                        self.movieImageView.image = scaledImage
                    }
                }
                
            }
        }
        
    }

}
