//
//  LoginViewController.swift
//  BallerBuddy
//
//  Created by Raj Patel on 7/26/17.
//  Copyright © 2017 AdaptConsulting. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var loginRegisterButton: UIButton!
    @IBOutlet var profileImageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.nameTextField.delegate = self
//        self.emailTextField.delegate = self
//        self.passwordTextField.delegate = self
        
        segmentedControl.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
        
        loginRegisterButton.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
        
        
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView)))
        
        
//        self.hideKeyboardWhenTappedAround()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//    
//    }
//    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        print("Stopped editing text field")
//        self.viewDidLoad()
//        self.viewWillAppear(true)
//    }
//    
    func handleSelectProfileImageView(){
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage{
            
            selectedImageFromPicker = editedImage
            
        }else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
           profileImageView.layer.cornerRadius = 135.0/2
           profileImageView.clipsToBounds = true
           profileImageView.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func handleLoginRegisterChange(){
        let title = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)
        loginRegisterButton.setTitle(title, for: .normal)
        
        if segmentedControl.selectedSegmentIndex == 0 {
            nameTextField.isHidden = true
            profileImageView.isUserInteractionEnabled = false
        } else if segmentedControl.selectedSegmentIndex == 1 {
            nameTextField.isHidden = false
            profileImageView.isUserInteractionEnabled = true
        }
        
    }
    
    
    @IBAction func unwindToHomeScreen(segue:UIStoryboardSegue) {
        
        do {
           try FIRAuth.auth()?.signOut()
            print("Logged out")
        } catch let logoutError {
            print(logoutError)
        }
        
    }
    
    func handleLoginRegister(){
        if segmentedControl.selectedSegmentIndex == 0 {
            handleLogin()
        } else {
            registerUser()
        }
    }
    
    func handleLogin(){
        
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            print("Form is invalid")
            return
        }
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                print(error!)
                return
            }
            print("Successfully signed in")
            self.performSegue(withIdentifier: "login", sender: nil)
        })
        
    }
    
    
    func registerUser(){
        
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text else {
            print("Form is incomplete")
            return
        }
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user: FIRUser?, error) in
            if error != nil {
                print(error!)
                return
            }
            
            guard let uid = user?.uid else {
                return
            }
            
            // Successfully authenticated user
            let imageName = NSUUID().uuidString
            let storageRef = FIRStorage.storage().reference().child("profile_images").child("\(imageName).jpg")
           
            if let profileImage = self.profileImageView.image, let uploadData = UIImageJPEGRepresentation(profileImage, 0.1){
                
            
//            if let uploadData = UIImagePNGRepresentation(self.profileImageView.image!) {
             storageRef.put(uploadData, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let profileImageURL = metadata?.downloadURL()?.absoluteString {
                     let values = ["name": name, "email": email, "profileImageURL": profileImageURL]
                     self.registerUserInDatabaseWithUID(uid: uid,values: values as [String : AnyObject])
                }
                
               
                
                
             })
            }
            
            
            
        })
        print(123)
    }
    
    private func registerUserInDatabaseWithUID(uid: String, values: [String: AnyObject]){
        let ref = FIRDatabase.database().reference(fromURL: "https://ballerbuddy-8d922.firebaseio.com/")
        let usersReference = ref.child("users").child(uid)
        usersReference.updateChildValues(values, withCompletionBlock: { (err,ref) in
            
            if err != nil {
                print(err!)
                return
            }
            
            print("Saved user successfully into Firebase db")
            self.performSegue(withIdentifier: "login", sender: nil)
            
        })

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        if let enteredText = nameTextField.text {
           let groupName = enteredText
            print(groupName)
        }
        return true
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
