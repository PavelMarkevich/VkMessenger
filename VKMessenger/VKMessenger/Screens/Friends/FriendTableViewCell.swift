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
    
    func configure(with friend: UserModel) {
        nameLabel.text = friend.name
        photoView.image = UIImage(named: "photo")
    }
}
