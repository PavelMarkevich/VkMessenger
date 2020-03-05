//
//  ProfileViewController.swift
//  VKMessenger
//
//  Created by Admin on 05/12/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let viewModel: ProfileViewModel = ProfileViewModel()
    let network = NetworkServiceForUser()
    let service = VKSDKService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoImage.layer.cornerRadius = 30
        photoImage.contentMode = .scaleToFill
        photoImage.layer.masksToBounds = true
        loadProfile()
    }
    
    @IBAction func logout(_ sender: Any) {
        service.logout()
        AppDelegate.shared.window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
    }
    
    @IBOutlet weak var photoImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var bdateLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    func loadProfile() {
        viewModel.loadModel { [weak self] result in
            switch result {
            case .success(let model):
                self?.update(userModel: model)
                self?.updatePhoto(userModel: model)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func update(userModel: UserModel) {
        nameLabel.text = userModel.name
        bdateLabel.text = userModel.bdate
        statusLabel.text = userModel.status
    }
    
    func updatePhoto(userModel: UserModel) {
        network.getPhotoUser(userModel) { [weak self] result in
            self?.photoImage.image = result
        }
    }
}
