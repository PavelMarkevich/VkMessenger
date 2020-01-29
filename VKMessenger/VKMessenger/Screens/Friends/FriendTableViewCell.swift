//
//  FriendTableViewCell.swift
//  VKMessenger
//
//  Created by Admin on 29/01/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {

    @IBOutlet weak var photoView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        photoView.layer.cornerRadius = 35
        photoView.contentMode = .scaleAspectFill
        photoView.layer.masksToBounds = true
    }
}
