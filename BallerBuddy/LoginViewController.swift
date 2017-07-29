//
//  LoginViewController.swift
//  BallerBuddy
//
//  Created by Raj Patel on 7/26/17.
//  Copyright © 2017 AdaptConsulting. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var loginRegisterButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameTextField.delegate = self
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        segmentedControl.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
        
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
    func handleLoginRegisterChange(){
        let title = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)
        loginRegisterButton.setTitle(title, for: .normal)
        
    }
    
    
    @IBAction func unwindToHomeScreen(segue:UIStoryboardSegue) {
        
    }
    
    @IBAction func registerUser(sender: UIButton){
        
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
            let ref = FIRDatabase.database().reference(fromURL: "https://ballerbuddy-8d922.firebaseio.com/")
            let usersReference = ref.child("users").child(uid)
            let values = ["name": name, "email": email]
            usersReference.updateChildValues(values, withCompletionBlock: { (err,ref) in
                
                if err != nil {
                    print(err!)
                    return
                }
                
                print("Saved user successfully into Firebase db")
                
            })
            
        })
        print(123)
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
