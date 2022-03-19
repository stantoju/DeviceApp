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
        
        XCTAssertFalse(viewmodel.allDevices.isEmpty)
        XCTAssertFalse(viewmodel.displayDevices.isEmpty)
        XCTAssertNotNil(viewmodel.allDevices)
        XCTAssertNotNil(viewmodel.displayDevices)
        XCTAssertTrue(viewmodel.error.isEmpty)
        
    }
    
    func test_Failure_GetDevices() throws {
        viewmodel = generateViewmodel(successResponse: false)
        viewmodel.getDevices()
        
        XCTAssertFalse(viewmodel.error.isEmpty)
        XCTAssertTrue(viewmodel.displayDevices.isEmpty)
        XCTAssertTrue(viewmodel.allDevices.isEmpty)
    }
    
    func test_Empty_Search_Devices() throws {
        viewmodel = generateViewmodel(successResponse: true)
        viewmodel.getDevices()
        
        viewmodel.searchDevices(query: "")
        XCTAssertFalse(viewmodel.allDevices.isEmpty)
        XCTAssertFalse(viewmodel.displayDevices.isEmpty)
        XCTAssertEqual(viewmodel.displayDevices.count, viewmodel.allDevices.count)
        
    }
    
    
    func test_Valid_Empty_Search_Devices() throws {
        viewmodel = generateViewmodel(successResponse: true)
        viewmodel.getDevices()

        viewmodel.searchDevices(query: "Sens")
        XCTAssertFalse(viewmodel.allDevices.isEmpty)
        XCTAssertEqual(viewmodel.displayDevices.count, 1)
        XCTAssertNotEqual(viewmodel.displayDevices.count, viewmodel.allDevices.count)

    }
    
    func test_Search_With_No_Result_Devices() throws {
        viewmodel = generateViewmodel(successResponse: true)
        viewmodel.getDevices()

        viewmodel.searchDevices(query: "XXCCxxcd")
        XCTAssertFalse(viewmodel.allDevices.isEmpty)
        XCTAssertTrue(viewmodel.displayDevices.isEmpty)
        XCTAssertNotEqual(viewmodel.displayDevices.count, viewmodel.allDevices.count)

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
