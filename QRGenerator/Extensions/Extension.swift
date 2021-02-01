//
//  Extension.swift
//  QRGenerator
//
//  Created by Mangrulkar on 01/02/21.
//  Copyright © 2021 Vibha. All rights reserved.
//

import UIKit

import Foundation

/// All string extensions
extension String {
    
    /// Get localized string
    /// - Parameters:
    ///   - bundle: Search in main bundle
    ///   - tableName: Search Localizable file
    /// - Returns: Localized string
    func localized (bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "\(self)", comment: "")
    }

}


