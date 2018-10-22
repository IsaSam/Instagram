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
    
    var post: Post! {
        didSet {
            //self.photoImageView.file = post.media
            //self.photoImageView.loadInBackground()
            self.usernameLabel.text = post.author.username
            //self.commentUsernameLabel.text = post.author.username
            self.captionLabel.text = post.caption
            self.profilImageView.image = UIImage(named: "insta-colors")
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
