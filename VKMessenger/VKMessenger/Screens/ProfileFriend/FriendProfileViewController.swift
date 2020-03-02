//
//  FriendProfileViewController.swift
//  VKMessenger
//
//  Created by Admin on 02/03/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class FriendProfileViewController: UIViewController {

    @IBOutlet weak var navigationBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func leftBarButton(_ sender: Any) {
        AppDelegate.shared.window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController")
    }
    
    
}
