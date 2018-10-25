//
//  SignUpViewController.swift
//  Instagram
//
//  Created by Isaac Samuel on 10/22/18.
//  Copyright © 2018 Isaac Samuel. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {
    /*
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var fullnameField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    */
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var fullnameField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.29, green: 0.44, blue: 0.7, alpha: 1.0)
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        signUp()
    }
    @IBAction func onSignUpButton(_ sender: Any) {
        signUp()
    }
    
    func signUp(){
        let newUser = PFUser()
        newUser.username = usernameField.text ?? ""
        newUser.password = passwordField.text ?? ""
        
        newUser.signUpInBackground{(success: Bool, error: Error?) in
            if success{
                print("User created successfully!")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }else{
                //print(error?.localizedDescription?)
                print(error!.localizedDescription)
                  if error?._code == 202{
                 print("Account already exists for this username.")
                 
                 }
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
