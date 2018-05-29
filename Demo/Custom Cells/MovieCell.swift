//
//  MovieTableViewCell.swift
//  Demo
//
//  Created by Muhammad Amir Pervaiz on 5/28/18.
//  Copyright © 2018 Muhammad Amir Pervaiz. All rights reserved.
//

import UIKit
import SDWebImage
class MovieCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var overview: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureWith(_ item: Movie )  {
        
        self.name.text = item.title;
        self.releaseDate.text = item.release_date
        self.overview.text = item.overview
        if let imageURL = item.poster_path {
            self.movieImageView.sd_setImage(with: URL.init(string: "https://image.tmdb.org/t/p/w500\(imageURL)") , completed: nil)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
