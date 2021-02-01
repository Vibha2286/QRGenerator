//
//  ShareViewModel.swift
//  QRGenerator
//
//  Created by Mangrulkar on 31/01/21.
//  Copyright © 2021 Vibha. All rights reserved.
//

import Foundation

class ShareViewModel {
    
    private weak var view: ShareView?
    
    /// Intialize share view
    /// - Parameter view: View object
    init(view: ShareView) {
        self.view = view
    }
    
    /// Configure initial view
    func configureInitialView() {
        view?.configureData()
    }
    
    /// Show success alert
    func showSuccessAlert() {
        view?.showAlert()
    }
    
    /// Save user detail data
    func saveData() {
        view?.saveDataToUserDefault()
    }
    
    /// Share user detail data
    func shareUserDetails() {
        view?.shareData()
    }
    
}
