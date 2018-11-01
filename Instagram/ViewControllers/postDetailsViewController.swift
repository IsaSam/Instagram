//
//  postDetailsViewController.swift
//  Instagram
//
//  Created by Isaac Samuel on 10/31/18.
//  Copyright © 2018 Isaac Samuel. All rights reserved.
//

import UIKit
import Parse

class postDetailsViewController: UIViewController {
    @IBOutlet weak var photoDetailPost: UIImageView!
    
    var post : Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let imageFile : PFFile = post?.media {
            imageFile.getDataInBackground { (data, error) in
                if (error != nil) {
                    print(error.debugDescription)
                }
                else {
                    self.photoDetailPost.image = UIImage(data: data!)
                }
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
