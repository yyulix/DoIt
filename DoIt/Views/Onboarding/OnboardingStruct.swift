//
//  Onboarding.swift
//  DoIt
//
//  Created by Данил Швец on 28.11.2021.
//

import UIKit

struct Onboarding {
    let image: String?
    let titleText: String?
    let labelText: String?
    
    private var index: Int
    
    init(index: Int){
        self.index = index
        switch index {
        case 0:
            self.image = ""
            self.titleText = ""
            self.labelText = ""
        case 1:
            self.image = ""
            self.titleText = ""
            self.labelText = ""
        case 2:
            self.image = ""
            self.titleText = ""
            self.labelText = ""
        case 3:
            self.image = ""
            self.titleText = ""
            self.labelText = ""
        default:
            self.image = ""
            self.titleText = ""
            self.labelText = ""
        }
    }
}
