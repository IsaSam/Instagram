//
//  LoginViewController.swift
//  Instagram
//
//  Created by Isaac Samuel on 10/14/18.
//  Copyright © 2018 Isaac Samuel. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func onSignIn(_ sender: Any) {
        signIn()
    }
    
    @IBAction func onSignInButton(_ sender: Any) {
        signIn()
    }
    func signIn(){
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            
            if username.isEmpty || password.isEmpty{
                print("Username or password is missing")
            }else if user != nil{
                print("Login success!")
                
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
    }
    }

    /*
    @IBAction func onSignUp(_ sender: Any) {

    }*/


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
