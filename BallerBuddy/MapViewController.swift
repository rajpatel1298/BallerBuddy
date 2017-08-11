//
//  MapViewController.swift
//  BallerBuddy
//
//  Created by Raj Patel on 7/25/17.
//  Copyright © 2017 AdaptConsulting. All rights reserved.
//

import UIKit
import Firebase

class MapViewController: UIViewController {
    
    @IBOutlet var menuButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addSideBarMenu(leftMenuButton: menuButton)
        
        
        if(FIRAuth.auth()?.currentUser?.uid == nil){
            print("No one is signed in")
        }
        
        print(FIRAuth.auth()?.currentUser?.email)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func handleLogout(){
//        
//        let loginController = LoginViewController()
//        present(loginController, animated: true, completion: nil)
//    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
