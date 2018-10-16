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
        print("Log Out Successfully")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
