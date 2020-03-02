//
//  FriendTableViewCell.swift
//  VKMessenger
//
//  Created by Admin on 29/01/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {

    var networkService: NetworkServiceForUser = NetworkServiceForUser()
    var user: UserModel!
    
    @IBOutlet weak var photoView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        networkService.cancelForUser(user)
    }

    func configure(with user: UserModel) {
        self.user = user
        nameLabel.text = user.name
        networkService.getPhotoUser(user, completion: { (result) in
            DispatchQueue.main.async {
                self.photoView.image = result
            }
        })
    }
}
