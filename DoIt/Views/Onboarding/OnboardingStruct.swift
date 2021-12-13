//
//  Onboarding.swift
//  DoIt
//
//  Created by Данил Швец on 28.11.2021.
//

import UIKit

struct Onboarding {
    let image: UIImage
    let titleText: String
    let labelText: String
    
    private var index: Int
    
    init(index: Int){
        self.index = index
        switch index {
        case 0:
            image = UIImage()
            titleText = ""
            labelText = ""
        case 1:
            image = UIImage()
            titleText = ""
            labelText = ""
        case 2:
            image = UIImage()
            titleText = ""
            labelText = ""
        case 3:
            image = UIImage()
            titleText = ""
            labelText = ""
        default:
            image = UIImage()
            titleText = ""
            labelText = ""
        }
    }
}
