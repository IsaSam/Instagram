//
//  InstaViewController.swift
//  Instagram
//
//  Created by Isaac Samuel on 10/16/18.
//  Copyright © 2018 Isaac Samuel. All rights reserved.
//

import UIKit
import Parse


fileprivate let headerReuseIden = "profileViewID"

class InstaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [Post]()
    var refreshControl: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.29, green: 0.44, blue: 0.7, alpha: 1.0)
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        
        // Initialize a UIRefreshControl
        self.refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        
        // add refresh control to table view
        tableView.insertSubview(refreshControl, at: 0)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        
        onTimer()
        Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(InstaViewController.onTimer), userInfo: nil, repeats: false)
        refreshEvery()
    }

    @objc func refreshControlAction(_ refreshControl: UIRefreshControl) {
        onTimer()
  }
    @objc func onTimer(){
        let query = Post.query()
        query?.order(byDescending: "createdAt")
        query?.includeKey("author")
        query?.order(byDescending: "createdAt")
        query?.limit = 20
        query?.findObjectsInBackground { (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil {
                // The find succeeded.
                self.posts = objects! as! [Post]
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
                
            }
            else {
                print(error!.localizedDescription)
            }
        }
        
        //tableView.reloadData()
    }
    @IBAction func onLogOut(_ sender: Any) {
        //print("Log Out Successfully")
        let actionSheet = UIAlertController(title: "Closing Session", message: "Are you sure you want to log Out?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Disconnect Session", style: .default, handler: {(UIAlertAction) in
            NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return posts.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        let post = posts[indexPath.row]
        
        if let imageFile : PFFile = post.media{
            imageFile.getDataInBackground { (data,error) in
                if (error != nil) {
                    print(error.debugDescription)
                }
                else{
                    cell.photoImageView?.image = UIImage(data: data!)
                }
            }
        }
        cell.captionLabel?.text = post.caption
        cell.usernameLabel.text = post.author.username
        //cell.profilImageView.image =  UIImage(named: "insta-colors")
        cell.userLabel.text = post.author.username
        cell.countLikes.text = post.likesCount.description
        
        if let userProfileImage = post.object(forKey: "userProfileImage") as? PFFile {
            userProfileImage.getDataInBackground({ (imageData: Data?, error: Error?) -> Void in
                let image = UIImage(data: imageData!)
                if image != nil {
                    //cell.profilePicImageView.image = image
                    cell.profilImageView.image = image
                }
            })
        }
        
        let timestamp = post.createdAt
        cell.timeLabel.text = String(describing: formatTimestamp(date: timestamp!))
        
        cell.captionLabel.text = post["caption"] as? String

        return cell
}
    func formatTimestamp(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
        let timestamp = dateFormatter.string(from: date)
        return timestamp
    }

    func refreshEvery() {
        Timer.scheduledTimer(timeInterval: 15, target: self, selector: #selector(InstaViewController.onTimer), userInfo: nil, repeats: true)
    }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     let postdetail = segue.destination as? postDetailsViewController
     if let cell = sender as! PhotoCell? {
     if let indexpath = tableView.indexPath(for: cell) {
     let post = posts[indexpath.row]
     //postdetail.post = post
        postdetail?.post = post
     }
     }
     
     }
    
}


