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
    @IBOutlet weak var favoritesFriends: UIBarButtonItem!
    
    @IBAction func addOrRemove(_ sender: UIButton) {
        let controller = navigationController?.viewControllers[0]
        if controller is FriendsViewController {
            if viewModel.friendCheckIsFavourite() {
                viewModel.delete()
            } else {
                viewModel.save()
            }
             favoritesFriends.title = viewModel.friendCheckIsFavourite() ? "Delete" : "Add"
        } else {
            viewModel.delete()
            navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        update()
        favoritesFriends.title = viewModel.friendCheckIsFavourite() ? "Delete" : "Add"
    }
    
    func update() {
        let user = viewModel.user
        nameLabel.text = user?.name
        bdateLabel.text = user?.bdate
        statusLabel.text = user?.status
        navigationItem.title = "id" + "\((user?.id)!)"
        let controller = navigationController?.viewControllers[0]
        if controller is FriendsViewController {
            network.getPhotoUser(user) { [weak self] result in
                self?.photoImage.image = result
            }
        } else {
            photoImage.image = UIImage(data: (user?.data)!)
        }
    }
}
