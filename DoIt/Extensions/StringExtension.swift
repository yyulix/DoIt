//
//  StringExtension.swift
//  DoIt
//
//  Created by Y u l i a on 27.10.2021.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
