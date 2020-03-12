//
//  FavoritesFriendsViewController.swift
//  VKMessenger
//
//  Created by Admin on 05/03/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class FavoritesFriendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let viewModel: FavoritesFriendsViewModel = FavoritesFriendsViewModel()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fearchRequest()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! FavoritesTableViewCell
        let name = viewModel.getUserName(for: indexPath)
        cell.configure(name: name)
        return cell
    }
}
