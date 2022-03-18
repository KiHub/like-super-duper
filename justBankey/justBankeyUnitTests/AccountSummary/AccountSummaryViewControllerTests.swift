//
//  AccountSummaryViewControllerTests.swift
//  justBankeyUnitTests
//
//  Created by  Mr.Ki on 18.03.2022.
//

import Foundation
import XCTest

@testable import justBankey

class AccountSummaryViewControllerTests: XCTestCase {
    var vc: AccountSummaryViewController!
    
    override func setUp() {
        super.setUp()
        vc = AccountSummaryViewController()
        // vc.loadViewIfNeeded()
    }
    
    func testTitleAndMessageForServerError() throws {
        let titleAndMessage = vc.titleAndMessageForTesting(for: .serverError)
        XCTAssertEqual("Server Error", titleAndMessage.0)
        XCTAssertEqual("Check your internet connection", titleAndMessage.1)
    }
    func testTitleAndMessageForDecodingError() throws {
        let titleAndMessage = vc.titleAndMessageForTesting(for: .decodingError)
        XCTAssertEqual("Network Error", titleAndMessage.0)
        XCTAssertEqual("We could not process your request", titleAndMessage.1)
    }
}
