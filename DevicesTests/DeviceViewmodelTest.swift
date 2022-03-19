//
//  DeviceViewmodelTest.swift
//  DevicesTests
//
//  Created by Toju on 19/03/2022.
//

import XCTest
@testable import Devices

class DeviceViewmodelTest: XCTestCase {
    
    var viewmodel: DeviceViewmodel!

    override func tearDownWithError() throws {
        viewmodel = nil
    }

    func test_Successful_GetDevices() throws {
        viewmodel = generateViewmodel(successResponse: true)
        viewmodel.getDevices()
        
        XCTAssertFalse(viewmodel.devices.isEmpty)
        XCTAssertNotNil(viewmodel.devices)
        XCTAssertTrue(viewmodel.error.isEmpty)
        
    }
    
    func test_Failure_GetDevices() throws {
        viewmodel = generateViewmodel(successResponse: false)
        viewmodel.getDevices()
        
        XCTAssertFalse(viewmodel.error.isEmpty)
        XCTAssertTrue(viewmodel.devices.isEmpty)
    }


}


extension DeviceViewmodelTest {
    
    //MARK: - Helper function to generate DeviceViewmodel
    private func generateViewmodel(successResponse: Bool) -> DeviceViewmodel {
        let mockApi = MockHttpClient.shared
        if successResponse {
            //MARK: -  Returns successful response from Mock
            mockApi.successfulResponse = true
        } else {
            //MARK: -  Returns failure response from Mock
            mockApi.successfulResponse = false
        }
        let repository = DeviceRepository(httpClient: mockApi)
        let usecase = DeviceUsecase(repository: repository)
        return DeviceViewmodel(usecase: usecase)
    }
    
}
