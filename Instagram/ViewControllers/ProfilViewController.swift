//
//  ProfilViewController.swift
//  Instagram
//
//  Created by Isaac Samuel on 10/18/18.
//  Copyright © 2018 Isaac Samuel. All rights reserved.
//

import UIKit

class ProfilViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let actionSheet = UIAlertController(title: "Profil", message: "", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "View Profile", style: .default, handler: {(UIAlertAction) in}))
        actionSheet.addAction(UIAlertAction(title: "Disconnect Session", style: .default, handler: {(UIAlertAction) in}))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
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
