//
//  FriendsViewController.swift
//  VKMessenger
//
//  Created by Admin on 05/12/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import VK_ios_sdk

class FriendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let viewModel: FriendViewModel = FriendViewModel()
    
    var user = [UserModel]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFriend()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! FriendTableViewCell
        cell.nameLabel.text = self.user[indexPath.row].name
        cell.photoView.image = UIImage(named: "photo")
        return cell
    }
    
    func loadFriend() {
        viewModel.loadModel { [weak self] result in
            switch result {
            case .success(let model):
                self?.user = model
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

