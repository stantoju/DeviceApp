//
//  DeviceUsecaseTest.swift
//  DevicesTests
//
//  Created by Toju on 19/03/2022.
//

import XCTest
@testable import Devices

class DeviceUsecaseTest: XCTestCase {
    
    var usecase: DeviceUsecase!

    override func tearDownWithError() throws {
        usecase = nil
    }

    func test_Success_Get_Devices() throws {
        usecase = generateUsecase(successResponse: true)
        usecase.getDevices { devices in
            XCTAssertNotNil(devices)
            XCTAssertFalse(devices!.isEmpty)
            XCTAssertTrue((devices as Any) is [Device])
        } error: { _ in
            XCTFail("Expects success response of [User], but recieved Error")
        }
    }
    
    

    func test_Failure_Get_Devices() throws {
        usecase = generateUsecase(successResponse: false)
        usecase.getDevices { devices in
            XCTFail("Expects error response of String, but recieved Success")
        } error: { err in
            XCTAssertTrue((err as Any) is String)
            XCTAssertNotNil(err)
            XCTAssertFalse(err!.isEmpty)
        }
    }
    

}



extension DeviceUsecaseTest {
    
    //MARK: - Helper function to generate DeviceUsecase
    private func generateUsecase(successResponse: Bool) -> DeviceUsecase {
        let mockApi = MockHttpClient.shared
        if successResponse {
            //MARK: -  Returns successful response from Mock
            mockApi.successfulResponse = true
        } else {
            //MARK: -  Returns failure response from Mock
            mockApi.successfulResponse = false
        }
        let repository =  DeviceRepository(httpClient: mockApi)
        return DeviceUsecase(repository: repository)
    }
    
}
