//
//  DeviceRepositoryTest.swift
//  DevicesTests
//
//  Created by Toju on 19/03/2022.
//

import XCTest
@testable import Devices

class DeviceRepositoryTest: XCTestCase {
    
    var repository: DeviceRepository!
    

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        repository = nil
    }

    // MARK: Test successful call from Api
    func test_Successful_Fetch_Device_From_Api() throws {
        repository = generateRepository(successResponse: true)
        repository.getDeviceFromRemote { result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
                XCTAssertFalse(response.devices!.isEmpty)
                XCTAssertTrue((response as Any) is RemoteResponse)
            case .failure(_):
                XCTFail("Expected success, but got error response")
            }
        }
    }
    
    // MARK: Test failure call from Api
    func test_Failure_Fetch_Device_From_Api() throws {
        repository = generateRepository(successResponse: false)
        repository.getDeviceFromRemote { result in
            switch result {
            case .success(_):
                XCTFail("Expected error, but got success response")
            case .failure(let err):
                //MARK: - Ensure there's and error upon failure
                XCTAssertNotNil(err)
            }
        }
    }



}


extension DeviceRepositoryTest {
    
    //MARK: - Helper function to generate DeviceRepository
    private func generateRepository(successResponse: Bool) -> DeviceRepository {
        let mockApi = MockHttpClient.shared
        if successResponse {
            //MARK: -  Returns successful response from Mock
            mockApi.successfulResponse = true
        } else {
            //MARK: -  Returns failure response from Mock
            mockApi.successfulResponse = false
        }
        return DeviceRepository(httpClient: mockApi)
    }
    
}
