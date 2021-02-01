//
//  ShareViewModelTests.swift
//  QRGeneratorTests
//
//  Created by Mangrulkar on 01/02/21.
//  Copyright © 2021 Vibha. All rights reserved.
//

import XCTest

@testable import QRGenerator

class shareMockedView: ShareView {
    
    fileprivate var isConfigure = false
    fileprivate var isShowAlert = false
    fileprivate var isSaveData = false
    fileprivate var isShareData = false
    
    func configureData() { isConfigure = true }
    
    func showAlert() { isShowAlert = true }
    
    func saveDataToUserDefault() { isSaveData = true }
    
    func shareData() { isShareData = true }
    
}

class ShareViewModelTests: XCTestCase {
    
    private var systemUnderTest: ShareViewModel!
    private var mockedView = shareMockedView()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        systemUnderTest = ShareViewModel(view: mockedView)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        systemUnderTest = nil
    }

    func testConfigureInitialView() {
        systemUnderTest.configureInitialView()
        XCTAssertTrue(mockedView.isConfigure)
    }
    
    func testShowSuccessAlert() {
        systemUnderTest.showSuccessAlert()
        XCTAssertTrue(mockedView.isShowAlert)
    }
    
    func testSaveData() {
        systemUnderTest.saveData()
        XCTAssertTrue(mockedView.isSaveData)
    }
    
    func testShareUserDetails() {
        systemUnderTest.shareUserDetails()
        XCTAssertTrue(mockedView.isShareData)
    }

}
