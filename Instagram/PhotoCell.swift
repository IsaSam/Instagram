//
//  PhotoCell.swift
//  Instagram
//
//  Created by Isaac Samuel on 10/18/18.
//  Copyright © 2018 Isaac Samuel. All rights reserved.
//

import UIKit
import Parse
//import ParseUI

class PhotoCell: UITableViewCell {

    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profilImageView: UIImageView!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    @IBOutlet weak var countLikes: UILabel!
    
    @IBOutlet weak var addLike: UIImageView!
    @IBOutlet weak var addComment: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    var post: Post! {
        didSet {
            
            self.usernameLabel.text = post.author.username
            self.userLabel.text = post.author.username
            //self.commentLabel.text = post.author.username
            self.captionLabel.text = post.caption
            self.profilImageView.image = UIImage(named: "insta-colors")
            self.countLikes.text = post.likesCount.description

        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.profilImageView.layer.cornerRadius = self.profilImageView.bounds.width/2
        self.profilImageView.clipsToBounds = true
        self.selectionStyle = .none
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
