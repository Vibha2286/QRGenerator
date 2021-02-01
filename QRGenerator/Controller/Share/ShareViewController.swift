//
//  ShareViewController.swift
//  QRGenerator
//
//  Created by Mangrulkar on 29/01/21.
//  Copyright © 2021 Vibha. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController {
    
    @IBOutlet weak var qrcodeImage: UIImageView!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    private lazy var viewModel = ShareViewModel(view: self)
    var userDetails : UserDetails!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bindData()
    }
    
    /// Bind data for initialization of view
    func bindData() {
        viewModel.configureInitialView()
    }
    
    /// Action to pop the controller
    /// - Parameter sender: sender object
    @IBAction func ActionToPopController(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /// Action to save user details
    /// - Parameter sender: sender object
    @IBAction func ActionToSaveUserDetails(_ sender: Any) {
        viewModel.saveData()
    }
    
    /// Action to share contact
    /// - Parameter sender: sender object
    @IBAction func ActionToShareContact(_ sender: Any) {
        viewModel.shareUserDetails()
    }
    
}

extension ShareViewController: ShareView {
    
    func showAlert() {
        var dashboardVC : UIViewController?
        let alert = UIAlertController(title: "alert.api.success".localized(), message: "alert.api.success.message".localized() , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "alert.button.title".localized(), style: .default, handler: { (_) in
            dashboardVC = self.navigationController?.viewControllers.first(where: {$0 is DashboardViewController})
            if let dashboardVC = dashboardVC {
                self.navigationController?.popToViewController(dashboardVC, animated: true)
            }
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func configureData() {
        qrcodeImage.image = UIImage(data: userDetails.imageData)
        nameLable.text = "nameField.title".localized() + "\(userDetails.name)"
        numberLabel.text = "numberField.title".localized() + "\(userDetails.number)"
    }
    
    func saveDataToUserDefault() {
        var dataArray = UserDefault.getUserContactDetails()
        dataArray.append(userDetails)
        UserDefault.setUserContactDetails(model: dataArray)
        viewModel.showSuccessAlert()
    }
    
    func shareData() {
        let shareData = UIActivityViewController(activityItems: [userDetails.name,userDetails.number, qrcodeImage.image!], applicationActivities: [])
        shareData.popoverPresentationController?.sourceView = self.view
        present(shareData, animated: true)
    }
}

extension ShareViewController {
    
    func popTo<T>(_ vc: T.Type) {
        let targetVC = navigationController?.viewControllers.first{$0 is T}
        if let targetVC = targetVC {
            navigationController?.popToViewController(targetVC, animated: true)
        }
    }
}
