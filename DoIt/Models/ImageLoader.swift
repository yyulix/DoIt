//
//  ImageLoader.swift
//  DoIt
//
//  Created by Шестаков Никита on 15.12.2021.
//

import Foundation
import UIKit
import Kingfisher

final class ImageLoader {
    static func downloadImage(url: URL?, complition: @escaping (UIImage?) -> ()) {
        guard let url = url else { return }
        DispatchQueue.global(qos: .userInitiated).async {
            KingfisherManager.shared.retrieveImage(with: url, options: nil, progressBlock: nil) { result in
                if let image = try? result.get().image {
                    complition(image)
                } else {
                    complition(nil)
                }
            }
        }
    }
}
