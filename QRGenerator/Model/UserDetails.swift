//
//  UserDetails.swift
//  QRGenerator
//
//  Created by Mangrulkar on 31/01/21.
//  Copyright © 2021 Vibha. All rights reserved.
//

import Foundation

// MARK: - CustomRequest
struct UserDetails: Codable {
    let imageData: Data
    let name: String
    let number: String
    
    init(withImageData data: Data, withName name: String, withNumber number: String) {
        self.imageData = data
        self.name = name
        self.number = number
    }
}
