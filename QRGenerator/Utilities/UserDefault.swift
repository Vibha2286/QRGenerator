//
//  UserDefault.swift
//  QRGenerator
//
//  Created by Mangrulkar on 31/01/21.
//  Copyright © 2021 Vibha. All rights reserved.
//

import UIKit

class UserDefault {
    
    /// Save the user contact details
    /// - Parameter model: model object
    static func setUserContactDetails(model: [UserDetails]) {
        if let encodedData = try? JSONEncoder().encode(model) {
            UserDefaults.standard.set(encodedData, forKey: "UserDetails")
        }
        UserDefaults.standard.synchronize()
    }
    
    /// Fetch the user contact details
    /// - Returns: model object
    static func getUserContactDetails() -> [UserDetails] {
        if let favouriteData = UserDefaults.standard.object(forKey: "UserDetails") as? Data {
            if let offlineData = try? JSONDecoder().decode([UserDetails].self, from: favouriteData) {
                return offlineData
            }
        }
        return []
    }
    
    /// Remove object from saved data
    /// - Parameter index: index number
    static func userDetailRemoveAt(index: Int) {
        if let favouriteData = UserDefaults.standard.object(forKey: "UserDetails") as? Data {
            if var offlineData = try? JSONDecoder().decode([UserDetails].self, from: favouriteData) {
                offlineData.remove(at: index)
                setUserContactDetails(model: offlineData)
            }
        }
    }
    
}
