//
//  SearchUsersViewModel.swift
//  DoIt
//
//  Created by Шестаков Никита on 14.12.2021.
//

import Foundation

class SearchUsersViewModel {
    var userModel: UserModel?
    
    var userModels: [UserModel] = []
    
    var filteredUsersModel: [UserModel]? {
        didSet {
//            tableView.reloadSections(IndexSet(integer: 0), with: .fade)
        }
    }
}
