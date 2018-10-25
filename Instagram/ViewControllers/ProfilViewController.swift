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

/*
fileprivate struct CollectionViewUI{
    static let UIEdgeSpace: CGFloat = 0
    static let MinmumLineSpace: CGFloat = 2
    static let MinmumInteritemSpace: CGFloat = 2
    static let cellCornerRadius: CGFloat = 0
}
*/
class ProfilViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,  UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var profileImageView: UIImageView!
    //@IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var galleryLabel: UILabel!
    @IBOutlet weak var usernameProfil: UILabel!
    
    
    let imagePicker = UIImagePickerController()
    let currentUser = PFUser.current()
    
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
        
        //self.profileImageView.image = UIImage(data: data!)
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
        profileImageView.clipsToBounds = true
        profileImageView.layer.borderWidth = 3
        profileImageView.layer.borderColor = UIColor.lightGray.cgColor
        
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
        //---------------
        self.imagePicker.delegate = self
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.29, green: 0.44, blue: 0.7, alpha: 1.0)
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        //self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        //self.logoutButton.tintColor = UIColor.white
        //self.editProfilePicButton.layer.cornerRadius = 5
        self.profileImageView.layer.cornerRadius = 45
        
        if let currentUsername = currentUser?["username"]!{
            usernameProfil.text = "  " + String(describing: currentUsername)
        }
        else{
            print("add a user profil")
        }
        
        
        if let userProfileImage = currentUser?.object(forKey: "userProfileImage") as? PFFile {
            userProfileImage.getDataInBackground({ (imageData: Data?, error: Error?) -> Void in
                let image = UIImage(data: imageData!)
                if image != nil {
                    self.profileImageView.image = image
                }
            })
        }
        //---------------
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
        /*let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = layout.minimumInteritemSpacing
        let cellsPerLine: CGFloat = 3
        let interItemSpacingTotal = layout.minimumInteritemSpacing * (cellsPerLine - 1)
        let width = collectionView.frame.size.width / cellsPerLine - interItemSpacingTotal / cellsPerLine
        layout.itemSize = CGSize(width: width, height: width * 3 / 2)*/
        return cell
    }
    // MARK: UIImagePickerController delegates
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.profileImageView.image = pickedImage
        }
        updateProfilePic()
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onEditProfilePic(_ sender: Any) {
        print("Changing profile picture")
        selectPhoto()
    }
    //@IBAction func onEditProfilPic(_ sender: Any) {
   
    //}
    func selectPhoto() {
        self.imagePicker.allowsEditing = true
        self.imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    func updateProfilePic() {
        if self.profileImageView.image == nil {
            print("profil blank")
            return
        }
        
        let profileImage = self.profileImageView!.image
        let profileImageFile = Post.getPFFileFromImage(image: profileImage)
        
        currentUser?.setObject(profileImageFile!, forKey: "userProfileImage")
        currentUser?.saveInBackground(block: { (saved: Bool, error: Error?) in
            if saved {
                print("Saved profile image")
            }
            else {
                print("Failed to save profile image: \(String(describing: error))")
            }
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
