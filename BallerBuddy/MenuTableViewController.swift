//
//  MenuTableViewController.swift
//  BallerBuddy
//
//  Created by Raj Patel on 7/26/17.
//  Copyright © 2017 AdaptConsulting. All rights reserved.
//

import UIKit
import Firebase

class MenuTableViewController: UITableViewController {
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var usernameLabel: UILabel!
    
    var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
//        fetchCurrentUser()
//        setUpView()
        
//        profileImageView.layer.cornerRadius = 50
//        profileImageView.clipsToBounds = true
        
    }

    func fetchCurrentUser(){
        if FIRAuth.auth()?.currentUser?.uid != nil {
            let uid = FIRAuth.auth()?.currentUser?.uid
            FIRDatabase.database().reference().child("users").child(uid!).observe(.value, with: { (snapshot) in
                
                 if let dictionary = snapshot.value as? [String: AnyObject] {
                    self.user.setValuesForKeys(dictionary)
                 }
                
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
                
            }, withCancel: nil)
        }
        
        print(user.name!)
        print(user.profileImageURL!)
    }
    
    
    func setUpView(){
        
        if let userName = user.name {
            self.usernameLabel.text = userName
        }
        
        if let imageURL = user.profileImageURL {
            if let url = NSURL(string: imageURL) {
                if let data = NSData(contentsOf: url as URL){
                    self.profileImageView.layer.cornerRadius = 50
                    self.profileImageView.clipsToBounds = true
                    self.profileImageView.image = UIImage(data: data as Data)
                }
            }
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    func fetchUser(){
//        FIRDatabase.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
//            
//            if let dictionary = snapshot.value as? [String: AnyObject] {
//                let user = User()
//                
//                // App will crash if class properties do not match up with firebase keys
//                user.setValuesForKeys(dictionary)
//                self.users.append(user)
//                
//                // This will crash because of background thread, so use dispatch_async to fix
//                DispatchQueue.main.async(execute: {
//                    self.tableView.reloadData()
//                })
//                
//            }
//            
//            
//            
//        }, withCancel: nil)
//    }
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
