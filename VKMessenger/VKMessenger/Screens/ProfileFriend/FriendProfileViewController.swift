//
//  FriendProfileViewController.swift
//  VKMessenger
//
//  Created by Admin on 02/03/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class FriendProfileViewController: UIViewController {
    
    let network = NetworkServiceForUser()
    let viewModel = FriendProfileViewModel()
    var user: UserModel!
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var bdateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    
    @IBAction func add(_ sender: Any) {
        viewModel.save(user)
    }
    
    @IBAction func deleteFavorite(_ sender: Any) {
        viewModel.delete(user)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        update()
    }
    
    func update() {
        nameLabel.text = user.name
        bdateLabel.text = user.bdate
        statusLabel.text = user.status
        navigationItem.title = "id" + "\(user.id)"
        network.getPhotoUser(user) { [weak self] result in
            self?.photoImage.image = result
        }
    }
    
}
