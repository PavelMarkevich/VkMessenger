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

    var arrayPhoto = [VKUser]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func regvest() {
        let request = VKApi.friends()?.get(["fields" : "nickname, photo_200_orig"])
            request?.execute(resultBlock: { (response) in
                self.arrayPhoto.append(((response?.parsedModel as! VKUsersArray).items.firstObject as! VKUser))
            }, errorBlock: { (error) in
            })
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
