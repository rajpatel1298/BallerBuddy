//
//  SlidebarMenu.swift
//  BallerBuddy
//
//  Created by Raj Patel on 7/25/17.
//  Copyright © 2017 AdaptConsulting. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func addSideBarMenu(leftMenuButton: UIBarButtonItem?, rightMenuButton: UIBarButtonItem? = nil) {
        
        if revealViewController() != nil {
            if let menuButton = leftMenuButton {
                menuButton.target = revealViewController()
                menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            }
            
            if let extraButton = rightMenuButton {
                revealViewController().rightViewRevealWidth = 150
                extraButton.target = revealViewController()
                extraButton.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            }
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
    }
    
}
