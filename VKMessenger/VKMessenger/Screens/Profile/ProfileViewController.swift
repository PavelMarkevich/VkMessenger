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
    
    let request = VKApi.users()?.get(["fields" : "nickname, photo_200_orig, home_town, online, education, status, university, bdate"])

    var arrayPhoto = [VKUser]()
    override func viewDidLoad() {
        super.viewDidLoad()
        regvest()
        // Do any additional setup after loading the view.
    }
    

    @IBOutlet weak var photoImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var bdateLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    func regvest() {
        self.request?.execute(resultBlock: { (response) in
            
            let url = URL(string: ((response?.parsedModel as! VKUsersArray).items.firstObject as! VKUser).photo_200_orig!)
            if let data = try? Data(contentsOf: url!) {
                self.photoImage.image = UIImage(data: data)
            }
            self.nameLabel.text = ((response?.parsedModel as! VKUsersArray).items.firstObject as! VKUser).first_name + " " + ((response?.parsedModel as! VKUsersArray).items.firstObject as! VKUser).last_name
            self.bdateLabel.text = ((response?.parsedModel as! VKUsersArray).items.firstObject as! VKUser).bdate
            self.statusLabel.text = ((response?.parsedModel as! VKUsersArray).items.firstObject as! VKUser).status
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
