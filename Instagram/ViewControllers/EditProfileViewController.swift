//
//  EditProfileViewController.swift
//  Instagram
//
//  Created by Isaac Samuel on 10/23/18.
//  Copyright © 2018 Isaac Samuel. All rights reserved.
//

import UIKit
import Parse

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var captionTextImage: UILabel!
    
    var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.29, green: 0.44, blue: 0.7, alpha: 1.0)
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        if profileImage.image == nil{
            InstantiateImagePicker()
        }
    }
    
    @IBAction func onSaveProfile(_ sender: Any) {
        Post.postUserImage(image: profileImage.image, withCaption: captionTextImage.text) { (success: Bool, error: Error?) in
            if success {
                print("Saving Profile Image")
                self.profileImage.image = nil
                NotificationCenter.default.post(name: NSNotification.Name("didSaveProfile"), object: nil)
            } else {
                print("error: \(String(describing: error))")
            }
        }
        
    }
    
    @IBAction func onCancel(_ sender: Any) {
                    NotificationCenter.default.post(name: NSNotification.Name("didCancelProfile"), object: nil)
    }
    class public func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    func imagePickerController(picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        profileImage.contentMode = .scaleAspectFill
        
        
        
        profileImage.image = originalImage
        dismiss(animated: true, completion: nil)
    }
    
    func InstantiateImagePicker(){
        let vc = UIImagePickerController()
        vc.delegate = self
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                print("Camera is available 📸")
                //vc.sourceType = .camera
                vc.allowsEditing = true
                vc.sourceType = UIImagePickerControllerSourceType.camera
            } else {
                print("Camera 🚫 available so we will use photo library instead")
                let alertController = UIAlertController(title: "Camera 🚫", message: "Camera is unavailable on this emulator device - Let's try Photo Library", preferredStyle: .alert)
                self.present(alertController, animated: true, completion: nil)
                // add the OK action to the alert controller
                alertController.addAction(UIAlertAction)
                
                
            }
            self.present(vc, animated: true, completion: nil)
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library ...", style: .default, handler: {(UIAlertAction) in
            vc.allowsEditing = true
            vc.sourceType = .photoLibrary
            self.present(vc, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    @IBOutlet weak var tapText: UIButton!
    @IBAction func tapProfileTake(_ sender: Any) {
        InstantiateImagePicker()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        // Do something with the images (based on your use case)
        profileImage.image = originalImage
        profileImage.image = editedImage
        // Dismiss UIImagePickerController to go back to your original view controller
        picker.dismiss(animated: true, completion: nil)
        //self.textImageTake.alpha = 0.05
        if tapText.isFocused{
            self.tapText.alpha = 1
        }else{
            tapText.alpha = 0.5
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    /*@IBAction func saveProfile(_ sender: Any) {
        if let avatorImage = self.profileImage.image{
            if let image = resize(image: avatorImage, newSize: profileImage){
                user[profileImageKey] = getPFFileFromImage(image: image) // PFFile column type
            }
        }
    }*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
