//
//  FavoritesTableViewCell.swift
//  VKMessenger
//
//  Created by Admin on 05/03/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    
    func configure(with user: UserModel) {
        nameLabel.text = user.name
        if let data = user.data {
            photoImage.image = UIImage(data: data)
        }
    }
}
