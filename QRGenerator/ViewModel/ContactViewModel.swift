//
//  ContactViewModel.swift
//  QRGenerator
//
//  Created by Mangrulkar on 29/01/21.
//  Copyright © 2021 Vibha. All rights reserved.
//

import Foundation
import UIKit

class ContactViewModel {
    
    private weak var view: ContactView?
    private let client = QRGeneratorAPIClient()
    
    /// Initialize view protocol
    /// - Parameter view: object
    init(view: ContactView) {
        self.view = view
    }
    
    /// Method for API call
    /// - Parameter requestData: request object
    func apiCall(_ requestData: CustomRequest) {
        self.view?.showIndicator()
        client.getGeneratedCode(requestData) { (data, error) in
            if let responseDeta = data {
                self.view?.hideIndicator()
                self.view?.navigateToRenderQRCode(responseDeta)
            } else {
                self.view?.hideIndicator()
                self.view?.showAlert("alert.api.failed".localized(), message: "alert.api.failed.message".localized())
            }
        }
    }
    
    /// Set button color for QR code background and foreground
    /// - Parameters:
    ///   - color: Color object
    ///   - tag: Button tag
    ///   - hexSting: Hex color string
    func setButtonColor(_ color: UIColor, tag: Int, hexSting: String) {
        if tag == FOREGROUND_COLOR_TAG {
            view?.setQrCodeForegroundColor(color, hexSting: hexSting)
        } else if tag == BACKGROUND_COLOR_TAG {
            view?.setQrCodeBackgroundColor(color, hexSting: hexSting)
        }
    }
    
    /// Validate text field value for emplty
    /// - Parameters:
    ///   - name: Name value
    ///   - number: Number value
    /// - Returns: Return true or false
    func validateTextField(name: String, number: String) -> Bool {
        if name.isEmpty || number.isEmpty {
            view?.showAlert("alert.title.validation".localized(), message: "alert.message.validation".localized())
            return true
        }
        return false
    }
    
}
