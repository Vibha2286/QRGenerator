//
//  ContactViewModelTests.swift
//  QRGeneratorTests
//
//  Created by Mangrulkar on 01/02/21.
//  Copyright © 2021 Vibha. All rights reserved.
//

import XCTest

@testable import QRGenerator

class ContactMockedView: ContactView {
    
    func navigateToRenderQRCode(_ data: Data?) { }
    
    func setQrCodeForegroundColor(_ color: UIColor, hexSting: String) { }
    
    func setQrCodeBackgroundColor(_ color: UIColor, hexSting: String) { }
    
    func showAlert(_ title: String, message: String) { }
    
    func showIndicator() { }
    
    func hideIndicator() { }
    
}

class ContactViewModelTests: XCTestCase {
    
    private var systemUnderTest: ContactViewModel!
    private var mockedView = ContactMockedView()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        systemUnderTest = ContactViewModel(view: mockedView)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        systemUnderTest = nil
    }

    func testapiCall() {
        let request = CustomRequest(data: "data", size: "size", color: "color", bgcolor: "bgcolor", margin: "margin", format: "format")
        systemUnderTest.apiCall(request)
    }
    
    func testSetButtonColor() {
        systemUnderTest.setButtonColor(.orange, tag: 0, hexSting: "#000000")
    }
    
    func testValidateTextField() {
        let value = systemUnderTest.validateTextField(name: "name", number: "number")
        XCTAssertFalse(value)
    }

}
