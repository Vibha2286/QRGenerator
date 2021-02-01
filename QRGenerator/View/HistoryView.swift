//
//  HistoryView.swift
//  QRGenerator
//
//  Created by Mangrulkar on 01/02/21.
//  Copyright © 2021 Vibha. All rights reserved.
//

import UIKit

protocol HistoryView: AnyObject  {

   func reloadTableView()
   func showAlert(_ title: String, message: String)
    
}
