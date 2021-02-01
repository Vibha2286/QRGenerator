//
//  DashboardViewController.swift
//  QRGenerator
//
//  Created by Mangrulkar on 28/01/21.
//  Copyright © 2021 Vibha. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var generateCodeButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    /// Action to generate the QR code
    /// - Parameter sender: sender object
    @IBAction func ActionToGenerateQRCode(_ sender: Any) {
        guard let detailsVC = STORYBOARD.instantiateViewController(withIdentifier: "ContactViewController") as? ContactViewController else {
            return
        }
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    /// Action to view history
    /// - Parameter sender: sender object
    @IBAction func ActionToViewHistory(_ sender: Any) {
        guard let historyVC = STORYBOARD.instantiateViewController(withIdentifier: "HistoryViewController") as? HistoryViewController else {
            return
        }
        self.navigationController?.pushViewController(historyVC, animated: true)
    }
    
}



