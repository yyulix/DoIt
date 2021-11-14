//
//  CustomUIElementsSearchFriends.swift
//  DoIt
//
//  Created by Шестаков Никита on 25.10.2021.
//

import UIKit

final class CustomSearchController: UISearchController {
    override init(searchResultsController: UIViewController?) {
        super.init(searchResultsController: searchResultsController)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(placeholder: String? = nil) {
        super.init(searchResultsController: nil)

        setup(placeholder: placeholder)
    }

    private func setup(placeholder: String? = nil) {
        obscuresBackgroundDuringPresentation = false
        searchBar.tintColor = .white
        searchBar.searchTextField.tintColor = .black
        searchBar.searchTextField.backgroundColor = .white
        searchBar.placeholder = placeholder
    }
}
