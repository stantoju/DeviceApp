//
//  DevicesTests.swift
//  DevicesTests
//
//  Created by Toju on 19/03/2022.
//

import XCTest
@testable import Devices

class MockHttpClientTest: XCTestCase {
    

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_GetData() throws {
        let data = MockHttpClient.shared.getJson()
        XCTAssertTrue((data as Any) is Data)
        XCTAssertFalse(data.isEmpty)
    }
    
}
