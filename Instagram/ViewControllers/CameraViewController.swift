//
//  CameraViewController.swift
//  Instagram
//
//  Created by Isaac Samuel on 10/16/18.
//  Copyright © 2018 Isaac Samuel. All rights reserved.
//

import UIKit
import Parse

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var captionTextImage: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if imageView.image == nil {
            InstantiateImagePicker()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSubmit(_ sender: Any) {
        Post.postUserImage(image: imageView.image, withCaption: captionTextImage.text) { (success: Bool, error: Error?) in
            if success {
                print("posting image")
                self.imageView.image = nil
                self.tabBarController?.selectedIndex = 0
            } else {
                print("error: \(String(describing: error))")
            }
        }
    }
    /*
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }*/
    
    
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
    @IBOutlet weak var textImageTake: UIButton!
    
    @IBAction func chooseImage(_ sender: Any) {
        InstantiateImagePicker()
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        // Do something with the images (based on your use case)
        imageView.image = originalImage
        imageView.image = editedImage
        // Dismiss UIImagePickerController to go back to your original view controller
        picker.dismiss(animated: true, completion: nil)
        //self.textImageTake.alpha = 0.05
        if textImageTake.isFocused{
            self.textImageTake.alpha = 1
        }else{
            textImageTake.alpha = 0.5
        }
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
 
}

