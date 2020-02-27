//
//  NetworkService.swift
//  VKMessenger
//
//  Created by Admin on 27/02/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit

class NetworkService {
    
    func getPhotoUser(user: UserModel, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let urlPhoto = user.urlPhoto else {
            return
        }
        
        let urlPhotoUser = URL(string: urlPhoto)
        
        guard let url = urlPhotoUser else {
            return
        }
        
        let configure = URLSessionConfiguration.default
        let request = URLRequest(url: url)
        let session = URLSession(configuration: configure)
        
        session.dataTask(with: request) { (data, responce, error) in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            if let data = data {
               DispatchQueue.main.async {
                let imagePhoto = UIImage(data: data)
                completion(.success(imagePhoto!))
               }
            }
        }.resume()
    }
}

