//
//  NetworkService.swift
//  VKMessenger
//
//  Created by Admin on 28/02/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit

class NetworkServiceForUser {
    
    let session = URLSession.shared
    var taskStorage: [NSNumber : URLSessionDataTask] =  [:]
    
    func cancelForUser(_ user: UserModel) {
        taskStorage[user.id]?.cancel()
    }
    
    func getPhotoUser(_ user: UserModel, completion: @escaping (UIImage) -> Void) {
        let image = UIImage(named: "photo")
        guard let urlPhoto = user.urlPhoto else {
            completion(image!)
            return
        }
        
        let urlPhotoUser = URL(string: urlPhoto)
        
        guard let url = urlPhotoUser else {
            completion(image!)
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { (data, responce, error) in
            guard error == nil else {
                completion(image!)
                return
            }
            if let data = data {
               DispatchQueue.main.async {
                let imagePhoto = UIImage(data: data)
                completion(imagePhoto!)
               }
            }
        }
        task.resume()
        taskStorage[user.id] = task
    }
}

