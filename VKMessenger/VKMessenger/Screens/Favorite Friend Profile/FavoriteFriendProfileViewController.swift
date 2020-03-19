//
//  FavoriteFriendProfileViewController.swift
//  VKMessenger
//
//  Created by Admin on 19/03/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class FavoriteFriendProfileViewController: UIViewController {
    
    var user: UserModel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bdateLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        update()
    }
    
    func update() {
        nameLabel.text = user.name
        bdateLabel.text = user.bdate
        statusLabel.text = user.status
        navigationItem.title = "id" + "\((user?.id)!)"
        if let data = user.data {
            photoImage.image = UIImage(data: data)
        }
    }
    
}
