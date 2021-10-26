//
//  CalculationTopbarHeightExtension.swift
//  DoIt
//
//  Created by Y u l i a on 27.10.2021.
//

import UIKit

extension UIViewController {
    var topbarHeight: CGFloat {
        var top = self.navigationController?.navigationBar.frame.height ?? 0.0
        if #available(iOS 13.0, *) {
            top += UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            top += UIApplication.shared.statusBarFrame.height
        }
        return top
    }
}
