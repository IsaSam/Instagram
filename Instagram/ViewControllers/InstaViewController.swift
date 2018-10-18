//
//  InstaViewController.swift
//  Instagram
//
//  Created by Isaac Samuel on 10/16/18.
//  Copyright © 2018 Isaac Samuel. All rights reserved.
//

import UIKit

class InstaViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

}
