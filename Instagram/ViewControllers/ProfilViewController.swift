//
//  ProfilViewController.swift
//  Instagram
//
//  Created by Isaac Samuel on 10/18/18.
//  Copyright © 2018 Isaac Samuel. All rights reserved.
//

import UIKit
import Parse


fileprivate let reuseIden = "GalleryCell"
fileprivate let headerReuseIden = "profileViewID"
//fileprivate let editProfileSegueIden = "EditProfile"

fileprivate struct CollectionViewUI{
    static let UIEdgeSpace: CGFloat = 0
    static let MinmumLineSpace: CGFloat = 2
    static let MinmumInteritemSpace: CGFloat = 2
    static let cellCornerRadius: CGFloat = 0
}

class ProfilViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var galleryLabel: UILabel!
    
    
    //@IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var posts = [Post]()
    /*var posts: [Post]?{
        didSet{
            //self.refreshControl.endRefreshing()
            self.collectionView.reloadData()
        }
    }*/
    
  /*
    var profileUser: PFUser? = PFUser.current(){
        didSet{
            self.isCurrentUserProfile = (self.profileUser?.username == PFUser.current()?.username)
            self.updateProfileUI()
        }
    }
 */
    //var profileUser: PFUser? = PFUser.current()
    //var isCurrentUserProfile = true
    
   /* var headerView: ProfilViewController{
        didSet{
            self.headerView.postCount = self.posts?.count ?? 0
            self.updateProfileUI()
        }
    }*/
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        //Do any additional setup after loading the view.
     //profileImageView.image = PFUser.current()
        let query = Post.query()
        query?.order(byDescending: "createdAt")
        query?.includeKey("author")
        query?.order(byDescending: "createdAt")
        query?.limit = 20
        query?.findObjectsInBackground { (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil {
                // The find succeeded.
                self.posts = (objects! as? [Post])!
                self.collectionView.reloadData()
            }
        }
        collectionView.reloadData()
    }
    
    @IBAction func editProfileButton(_ sender: Any) {
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCell", for: indexPath) as! GalleryCell
        let post = posts[indexPath.row]
        
        if let imageFile : PFFile = post.media{
            imageFile.getDataInBackground { (data,error) in
                if (error != nil) {
                    print(error.debugDescription)
                }
                else{
                    cell.imageCollection?.image = UIImage(data: data!)
                }
            }
        }
        return cell
    }




    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
