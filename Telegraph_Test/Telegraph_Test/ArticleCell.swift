//
//  ArticleCell.swift
//  Telegraph_Test
//
//  Created by Administrator on 05/04/2018.
//  Copyright © 2018 mahesh lad. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {

    @IBOutlet weak var headlineLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var pictureImageView: UIImageView!
    
    @IBOutlet weak var synopsisTextView: UITextView!
    
    @IBOutlet weak var actorsLabel: UILabel!
    
    
    @IBOutlet weak var genreLabel: UILabel!
    
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    
    @IBOutlet weak var durationLabel: UILabel!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var twitterLabel: UILabel!
    
    
    @IBOutlet weak var headShotImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
