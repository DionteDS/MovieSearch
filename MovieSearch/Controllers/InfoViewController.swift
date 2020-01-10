//
//  InfoViewController.swift
//  MovieSearch
//
//  Created by Dionte Silmon on 1/10/20.
//  Copyright © 2020 Dionte Silmon. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class InfoViewController: UIViewController {
    
    @IBOutlet weak var moviePosterImage: UIImageView!
    @IBOutlet weak var movieInfoField: UITextView!
    
    let baseURLImageString = "https://image.tmdb.org/t/p/w500"
    
    var mTitle: String?
    var imageSelectedURL: String?
    var summary: String?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = mTitle
        
        setupMovieInfo()
        
    }
    
    
    // MARK: - Setup The selected movie info
    func setupMovieInfo() {
        
        if let movieSummary = summary {
            self.movieInfoField.text = movieSummary
        }

        if let imageURL = imageSelectedURL {
            Alamofire.request(baseURLImageString + imageURL).responseImage { (response) in
                if let image = response.result.value {
                    // Get the view width divide it by 2 and then minus 5
                    // to get the width and height for the image
                    let width = (self.view.bounds.width / 2) - 5
                    let height = width
                    let size = CGSize(width: width, height: height)
                    let scaledImage = image.af_imageScaled(to: size)
                    DispatchQueue.main.async {
                        self.moviePosterImage.image = scaledImage
                    }
                }
            }
        }
        
    }
    

}
