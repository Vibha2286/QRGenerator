//
//  ContactViewController.swift
//  QRGenerator
//
//  Created by Mangrulkar on 28/01/21.
//  Copyright © 2021 Vibha. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var foregroundView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var marginSlider: UISlider!
    @IBOutlet weak var sizeSlider: UISlider!
    @IBOutlet weak var marginLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    
    private var foregroundColor : String!
    private var backgroundColor : String!
    private var popoverVC : ColorPickerViewController!
    
    lazy var viewModel = ContactViewModel(view: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initializeHideKeyboard()
    }
    
    // Generate popover on button press
    @IBAction func colorPickerButton(_ sender: UIButton) {
        popoverVC = storyboard?.instantiateViewController(withIdentifier: "colorPickerPopover") as? ColorPickerViewController
        popoverVC.modalPresentationStyle = .popover
        popoverVC.preferredContentSize = CGSize(width: 284, height: 446)
        popoverVC.view.tag = sender.tag
        if let popoverController = popoverVC.popoverPresentationController {
            popoverController.sourceView = sender
            popoverController.sourceRect = CGRect(x: 0, y: 0, width: 85, height: 30)
            popoverController.permittedArrowDirections = .any
            popoverController.delegate = self
            popoverVC.delegate = self
        }
        present(popoverVC, animated: true, completion: nil)
    }
    
    // Override the iPhone behavior that presents a popover as fullscreen
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        // Return no adaptive presentation style, use default presentation behaviour
        return .none
    }
    
    /// Action to pop the controller
    /// - Parameter sender: sender object
    @IBAction func ActionToPopController(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /// Action for margin value change
    /// - Parameter sender: sender object
    @IBAction func ActionForMarginValueChange(_ sender: Any) {
        marginLabel.text = "marginLabel.title".localized() + "\(Int(marginSlider.value))"
    }
    
    /// Action for size value change
    /// - Parameter sender: sender object
    @IBAction func ActionForSizeValueChange(_ sender: Any) {
        sizeLabel.text = "widthHeight.title".localized() + "\(Int(sizeSlider.value)) X \(Int(sizeSlider.value))"
    }
    
    /// Action to generate QR code
    /// - Parameter sender: sender object
    @IBAction func ActionForGenerateQRCode(_ sender: Any) {
        guard let name = nameTextField.text, let number = numberTextField.text else {
            return
        }
        
        let data = "name.title".localized() +  "\(name)" + "number.title".localized() + "\(number)"
        let customRequest = CustomRequest(data: data, size: "\(Int(sizeSlider.value ))*\(Int(sizeSlider.value))", color: foregroundColor ?? "", bgcolor: backgroundColor ?? "", margin: "\(Int(marginSlider.value))", format: "png")
        viewModel.apiCall(customRequest)
    }
}

extension ContactViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension ContactViewController: ContactView {
    
    /// View method to navigate to render QR code
    /// - Parameter data: data object
    func navigateToRenderQRCode(_ data: Data?) {
        
        guard let name = nameTextField.text, let number = numberTextField.text else {
            return
        }
        
        if viewModel.validateTextField(name: name, number: number) {
            return
        }
        
        guard let shareVC = STORYBOARD.instantiateViewController(withIdentifier: "ShareViewController") as? ShareViewController, let imageData = data else {
            return
        }
        
        let userDetails = UserDetails(withImageData: imageData, withName: name, withNumber: number)
        shareVC.userDetails = userDetails
        self.navigationController?.pushViewController(shareVC, animated: true)
    }
    
    /// View method to set QR code forground color
    /// - Parameters:
    ///   - color: Color object
    ///   - hexSting: Hex code value
    func setQrCodeForegroundColor(_ color: UIColor, hexSting: String) {
        foregroundView.backgroundColor = color
        foregroundColor = hexSting
        popoverVC.dismiss(animated: false, completion:nil)
        popoverVC = nil
    }
    
    /// View method to set QR code background color
    /// - Parameters:
    ///   - color: Color object
    ///   - hexSting: Hex code value
    func setQrCodeBackgroundColor(_ color: UIColor, hexSting: String) {
        backgroundView.backgroundColor = color
        backgroundColor = hexSting
        popoverVC.dismiss(animated: false, completion:nil)
        popoverVC = nil
    }
    
    /// View method to shoe alert
    /// - Parameters:
    ///   - title: Alert title
    ///   - message: Alert message
    func showAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "alert.button.title".localized(), style: .default, handler: { (_) in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    /// View method to show indicator
    func showIndicator() {
        ProgressIndicator.start(.large, UIColor.black.withAlphaComponent(0.5), .orange)
    }
    
    /// View method to hide indicator
    func hideIndicator() {
        ProgressIndicator.stop()
    }
    
}

extension ContactViewController {
    
    /// Initialize method to hide keyboard
    func initializeHideKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    /// Dismiss keyboard 
    @objc func dismissMyKeyboard(){
        view.endEditing(true)
    }
    
}

