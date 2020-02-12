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
    
    var userName = [String]()
    var filterUser = [String]()
    
    var userDictionary = [String: [String]]()
    var userSectionTitles = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchFriend: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchFriend.delegate = self
        loadFriend()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let userKey = userSectionTitles[section]
        if let userValues = userDictionary[userKey] {
            return userValues.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! FriendTableViewCell
        let userKey = userSectionTitles[indexPath.section]
        if let userValue = userDictionary[userKey] {
            cell.nameLabel.text = userValue[indexPath.row]
        }
        cell.photoView.image = UIImage(named: "photo")
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterUser = searchText.isEmpty ? userName : userName.filter{ $0.range(of: searchText, options: .caseInsensitive) != nil }
        viewModel.createDictionary(users: filterUser, dictionary: &userDictionary, userSection: &userSectionTitles)
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return userSectionTitles.count
    }
            
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return userSectionTitles[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return userSectionTitles
    }

    func loadFriend() {
        viewModel.loadModel { [weak self] result in
            switch result {
            case .success(let model):
                for i in 0..<model.count {
                    self?.userName.append(model[i].name)
                }
                self?.viewModel.createDictionary(users: self!.userName, dictionary: &self!.userDictionary, userSection: &self!.userSectionTitles)
                self?.filterUser = self!.userName
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

