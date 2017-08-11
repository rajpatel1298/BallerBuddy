//
//  NewMessageTableViewCell.swift
//  BallerBuddy
//
//  Created by Raj Patel on 7/29/17.
//  Copyright © 2017 AdaptConsulting. All rights reserved.
//

import UIKit

class NewMessageTableViewCell: UITableViewCell {
    
    @IBOutlet var contactImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
