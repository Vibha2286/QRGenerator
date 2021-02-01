//
//  HistoryViewModel.swift
//  QRGenerator
//
//  Created by Mangrulkar on 01/02/21.
//  Copyright © 2021 Vibha. All rights reserved.
//

import Foundation

class HistoryViewModel {
    
    private weak var view: HistoryView?
    private var userDetailsArray = [UserDetails]()
    
    /// Initialize history view
    /// - Parameter view: view object
    init(view: HistoryView) {
        self.view = view
        self.userDetailsArray = UserDefault.getUserContactDetails()
    }
    
    /// Configure initial view
    func configureView() {
        if UserDefault.getUserContactDetails().count == 0 {
            view?.showAlert("alert.api.noHistory".localized(), message: "alert.api.noHistory.message".localized())
        }
    }
    
    /// Add user details into user detail array
    /// - Parameter details: User details object
    func addUserDetailsIntoArray(details: UserDetails) {
        self.userDetailsArray.append(details)
        UserDefault.setUserContactDetails(model: self.userDetailsArray)
    }
    
    /// Remove user details from array
    /// - Parameter details: User details object
    func removeUserDetailsIntoArray(details: UserDetails) {
        
        if let index = userDetailsArray.firstIndex(where: { $0.imageData == details.imageData }) {
            userDetailsArray.remove(at: index)
        }
        UserDefault.setUserContactDetails(model: self.userDetailsArray)
    }
    
}
