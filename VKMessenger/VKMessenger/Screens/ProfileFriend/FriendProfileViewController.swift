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
    var user: UserModel!
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var bdateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        update()
    }
    
    @IBAction func leftBarButton(_ sender: Any) {
        AppDelegate.shared.window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController")
    }
    
    func update() {
        nameLabel.text = user.name
        bdateLabel.text = user.bdate
        statusLabel.text = user.status
        navigationBar.topItem?.title = "id" + "\(user.id)"
        network.getPhotoUser(user) { result in
            self.photoImage.image = result
        }
    }
    
}
