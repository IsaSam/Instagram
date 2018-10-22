//
//  InstaViewController.swift
//  Instagram
//
//  Created by Isaac Samuel on 10/16/18.
//  Copyright © 2018 Isaac Samuel. All rights reserved.
//

import UIKit
import Parse

class InstaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
   
    //var i = 0
    //var image: AnyObject?
    //var caption: String?
    //var posts: [Post] = []
    var posts = [Post]()
    //let query = Post.query()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.rowHeight = 200
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        
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
            }
        }
        tableView.reloadData()
        
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
        return cell
}
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Cancel"
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
    }*/
}


