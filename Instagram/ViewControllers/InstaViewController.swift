//
//  InstaViewController.swift
//  Instagram
//
//  Created by Isaac Samuel on 10/16/18.
//  Copyright © 2018 Isaac Samuel. All rights reserved.
//

import UIKit

class InstaViewController: UIViewController {
    @IBAction func onLogOut(_ sender: Any) {
        //print("Log Out Successfully")
        
        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
