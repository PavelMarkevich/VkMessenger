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
    var viewModel: FriendProfileViewModel!
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var bdateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var favoritesFriends: UIButton!
    
    @IBAction func addOrRemove(_ sender: UIButton) {
        let state = viewModel.chekStateButtton()
        if state {
            viewModel.delete()
            sender.isSelected = false
        } else {
            sender.isSelected = true
            viewModel.save()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        update()
        let state = viewModel.chekStateButtton()
        if state {
            favoritesFriends.isSelected = true
        }
    }
    
    func update() {
        let user = viewModel.user
        nameLabel.text = user?.name
        bdateLabel.text = user?.bdate
        statusLabel.text = user?.status
        navigationItem.title = "id" + "\((user?.id)!)"
        network.getPhotoUser(user) { [weak self] result in
            self?.photoImage.image = result
        }
    }
}
