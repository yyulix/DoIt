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
            self.image = "bob"
            self.titleText = "bob1"
            self.labelText = "bob11"
        case 1:
            self.image = "bob"
            self.titleText = "bob2"
            self.labelText = "bob22"
        case 2:
            self.image = "bob"
            self.titleText = "bob3"
            self.labelText = "bob33"
        case 3:
            self.image = "bob"
            self.titleText = "bob4"
            self.labelText = "bob44"
        default:
            self.image = ""
            self.titleText = ""
            self.labelText = ""
        }
    }
}
