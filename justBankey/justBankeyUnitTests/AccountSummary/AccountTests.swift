//
//  AccountTests.swift
//  justBankeyUnitTests
//
//  Created by  Mr.Ki on 16.03.2022.
//


import XCTest

@testable import justBankey

class AccountTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testCanParse() throws {
        let json = """
         [
           {
             "id": "1",
             "type": "Banking",
             "name": "Basic Savings",
             "amount": 929466.23,
             "createdDateTime" : "2010-06-21T15:29:32Z"
           },
           {
             "id": "2",
             "type": "Banking",
             "name": "No-Fee All-In Chequing",
             "amount": 17562.44,
             "createdDateTime" : "2011-06-21T15:29:32Z"
           },
          ]
        """

        let data = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let result1 = try! decoder.decode([Account].self, from: data)
        
        let accountOne = result1[0]
        
        XCTAssertEqual(accountOne.id, "1")
        XCTAssertEqual(accountOne.type , .Banking)
        XCTAssertEqual(accountOne.name , "Basic Savings")
        XCTAssertEqual(accountOne.amount , 929466.23)
        XCTAssertEqual(accountOne.createdDateTime.monthDayYearString , "июня 21, 2010")
        
       
        
       
    }
}
