//
//  ShareView.swift
//  QRGenerator
//
//  Created by Mangrulkar on 31/01/21.
//  Copyright © 2021 Vibha. All rights reserved.
//


import Foundation

protocol ShareView: AnyObject {
    
    func configureData()
    func showAlert()
    func saveDataToUserDefault()
    func shareData()
    
}
