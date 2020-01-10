//
//  CustomMovieTableViewCell.swift
//  MovieSearch
//
//  Created by Dionte Silmon on 1/9/20.
//  Copyright © 2020 Dionte Silmon. All rights reserved.
//

import UIKit

class CustomMovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
