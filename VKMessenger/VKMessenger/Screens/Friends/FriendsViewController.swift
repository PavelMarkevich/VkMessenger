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
    
    let request = VKApi.friends()?.get(["fields" : "nickname, photo_200_orig"])
    
    @IBOutlet weak var tableView: UITableView!
    
    var arrayName = [String]()
    var arrayPhoto = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        regvest()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arrayName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CustomTableViewCell
        cell.nameLabel.text = self.arrayName[indexPath.row]
        cell.photoView.layer.cornerRadius = 35
        cell.photoView.contentMode = .scaleAspectFill
        cell.photoView.layer.masksToBounds = true
        let url = URL(string: arrayPhoto[indexPath.row])
        if let data = try? Data(contentsOf: url!) {
            cell.photoView.image = UIImage(data: data)
        }
        return cell
    }
    
    func regvest() {
        self.request?.execute(resultBlock: { response in
            var arrayNickName = [VKUsersArray]()
            
            arrayNickName.append(((response?.parsedModel as! VKUsersArray)))
            for i in 0..<arrayNickName[0].count {
                self.arrayName.append(arrayNickName[0][i].first_name! + " " + arrayNickName[0][i].last_name!)
                self.arrayPhoto.append(arrayNickName[0][i].photo_200_orig)
            }
            self.tableView.reloadData()
            
        }, errorBlock: { (error) in

        })
    }
    
}

