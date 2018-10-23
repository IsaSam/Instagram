//
//  ProfilViewController.swift
//  Instagram
//
//  Created by Isaac Samuel on 10/18/18.
//  Copyright © 2018 Isaac Samuel. All rights reserved.
//

import UIKit

class ProfilViewController: UIViewController {
    @IBOutlet weak var profilImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var galleryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        let actionSheet = UIAlertController(title: "Profil", message: "", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "View Profile", style: .default, handler: {(UIAlertAction) in}))
        actionSheet.addAction(UIAlertAction(title: "Disconnect Session", style: .default, handler: {(UIAlertAction) in}))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)*/
        // Do any additional setup after loading the view.
    }
    
    @IBAction func editProfileButton(_ sender: Any) {
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
