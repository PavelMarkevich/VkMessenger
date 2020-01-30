//
//  FriendsViewController.swift
//  VKMessenger
//
//  Created by Admin on 05/12/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import VK_ios_sdk

class FriendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    let viewModel: FriendViewModel = FriendViewModel()
    
    var userName = [String]()
    
    var filterUser = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchFriend: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchFriend.delegate = self
        loadFriend()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! FriendTableViewCell
        cell.nameLabel.text = filterUser[indexPath.row]
        cell.photoView.image = UIImage(named: "photo")
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterUser = searchText.isEmpty ? userName : userName.filter{ $0.range(of: searchText, options: .caseInsensitive) != nil }
        tableView.reloadData()
    }
    
    func loadFriend() {
        viewModel.loadModel { [weak self] result in
            switch result {
            case .success(let model):
                for i in 0..<model.count {
                    self?.userName.append(model[i].name)
                }
                self?.filterUser = self!.userName
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

