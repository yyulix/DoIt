//
//  ImageService.swift
//  DoIt
//
//  Created by Yulia on 06.12.2021.
//

import Firebase
import UIKit

class ImageService {
    
    static let shared = ImageService()
    
    func uploadImage(image: UIImage!) {
        let filename = NSUUID().uuidString
        let storageRef = STORAGE_IMAGES.child(filename)
        if let imageData = image.pngData() {
            storageRef.putData(imageData, metadata: nil) { (meta, error) in
                storageRef.downloadURL { (url, error) in
                    guard let profileImageUrl =  url?.absoluteString else {return}
                }
            }
        }
    }
}
