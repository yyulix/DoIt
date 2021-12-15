//
//  ImageChacher.swift
//  DoIt
//
//  Created by Шестаков Никита on 15.12.2021.
//

import Foundation
import UIKit

class ImageCache {
    private let cache = NSCache<NSString, UIImage>()
    private var observer: NSObjectProtocol?
    
    static let shared = ImageCache()
    
    private init() {
        observer = NotificationCenter.default.addObserver(
            forName: UIApplication.didReceiveMemoryWarningNotification,
            object: nil, queue: nil) { [weak self] notification in
                self?.cache.removeAllObjects()
        }
    }
    
    deinit {
        guard let observer = observer else {
            return
        }

        NotificationCenter.default.removeObserver(observer)
    }
    
    func getImage(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    func save(image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}
