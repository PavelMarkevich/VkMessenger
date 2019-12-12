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
    
    
    var arrayNickName = [VKUsersArray]()
    var arrayName = [String]()
    
    let arrray = ["gkng","fgndgn","gndingin"]
    override func viewDidLoad() {
        super.viewDidLoad()
        regvest()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arrayName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = self.arrayName[indexPath.row]
        return cell!
    }
    
    func regvest() {
        self.request?.execute(resultBlock: { response in
            self.arrayNickName.append(((response?.parsedModel as! VKUsersArray)))
            for i in 0..<self.arrayNickName[0].count {
                self.arrayName.append(self.arrayNickName[0][i].first_name! + " " + self.arrayNickName[0][i].last_name!)
            }
            self.tableView.reloadData()
            print(self.arrayName)

        }, errorBlock: { (error) in

        })
    }
    
}

