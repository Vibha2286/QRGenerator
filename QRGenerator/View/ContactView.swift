//
//  ContactView.swift
//  QRGenerator
//
//  Created by Mangrulkar on 29/01/21.
//  Copyright © 2021 Vibha. All rights reserved.
//

import UIKit
import Foundation

protocol ContactView: AnyObject {

    func navigateToRenderQRCode(_ data: Data?)
    func setQrCodeForegroundColor(_ color: UIColor, hexSting: String)
    func setQrCodeBackgroundColor(_ color: UIColor, hexSting: String)
    func showAlert(_ title: String, message: String)
    func showIndicator()
    func hideIndicator()
    
}
