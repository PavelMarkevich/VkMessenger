//
//  FriendsViewController.swift
//  VKMessenger
//
//  Created by Admin on 05/12/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    let viewModel: FriendViewModel = FriendViewModel()
    let network: NetworkService = NetworkService()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchFriend: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchFriend.delegate = self
        loadFriend()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! FriendTableViewCell
        let user = viewModel.getUser(at: indexPath)
        return configureCell(cell: cell, user: user)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchBar(textDidChange: searchText)
        tableView.reloadData()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.countOfSections()
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.titleForHeaderInSection(section: section)
    }

    func loadFriend() {
        viewModel.loadModel { [weak self] result in
            switch result {
            case .success:
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func configureCell(cell: FriendTableViewCell, user: UserModel) -> UITableViewCell {
        network.getPhotoUser(user: user) { (result) in
            switch result {
            case .success(let image):
                cell.configure(with: user.name, image: image)
            case .failure(let error):
                print(error)
            }
        }
        return cell
    }
}

