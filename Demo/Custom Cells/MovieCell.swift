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
    
    var viewModel: MovieCellViewModel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureWith(_ item: Movie )  {
        
        viewModel = MovieCellViewModel(title: item.title, releaseDate: item.release_date, overview: item.overview, posterImage: item.poster_path)
        
        self.bindViewModel()
    }
    
    func bindViewModel() {
        self.name.text = viewModel.title;
        self.releaseDate.text = viewModel.releaseDate
        self.overview.text = viewModel.overview
        if let imageURL = viewModel.posterImage {
            self.movieImageView.sd_setImage(with: URL.init(string: "https://image.tmdb.org/t/p/w500\(imageURL)") , completed: nil)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
