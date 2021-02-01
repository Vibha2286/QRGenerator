//
//  HistoryViewModelTests.swift
//  QRGeneratorTests
//
//  Created by Mangrulkar on 01/02/21.
//  Copyright © 2021 Vibha. All rights reserved.
//

import XCTest

@testable import QRGenerator

class HistoryMockedView: HistoryView {
    
    fileprivate var isShowAlert = false
    
    func reloadTableView() { }
    
    func showAlert(_ title: String, message: String) { isShowAlert = true }
    
}

class HistoryViewModelTests: XCTestCase {
    
    private var systemUnderTest: HistoryViewModel!
    private var mockedView = HistoryMockedView()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        systemUnderTest = HistoryViewModel(view: mockedView)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        systemUnderTest = nil
    }

    func testConfigureView() {
        systemUnderTest.configureView()
        XCTAssertFalse(mockedView.isShowAlert)
    }
    
    func testAddUserDetailsIntoArray() {
        let details = UserDetails(withImageData: Data(), withName: "name", withNumber: "number")
        systemUnderTest.addUserDetailsIntoArray(details: details)
    }
    
    func testRemoveUserDetailsIntoArray() {
        let details = UserDetails(withImageData: Data(), withName: "name", withNumber: "number")
        systemUnderTest.removeUserDetailsIntoArray(details: details)
    }

}
