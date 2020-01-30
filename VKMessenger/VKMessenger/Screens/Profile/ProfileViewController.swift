//
//  ProfileViewController.swift
//  VKMessenger
//
//  Created by Admin on 05/12/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import VK_ios_sdk

class ProfileViewController: UIViewController {
    
    let viewModel: ProfileViewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadProfile()
    }
    
//    @IBAction func logout(_ sender: Any) {
//        
//    }
    
    @IBOutlet weak var photoImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var bdateLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    func loadProfile() {
        viewModel.loadModel { [weak self] result in
            switch result {
            case .success(let model):
                self?.update(userModel: model)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func update(userModel: UserModel) {
        nameLabel.text = userModel.name
        bdateLabel.text = userModel.bdate
        statusLabel.text = userModel.status
        photoImage.image = UIImage(named: "photo")
    }
}
