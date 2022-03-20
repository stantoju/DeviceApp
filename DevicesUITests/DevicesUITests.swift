//
//  DevicesUITests.swift
//  DevicesUITests
//
//  Created by Toju on 19/03/2022.
//

import XCTest

class DevicesUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func test_Search_Field_Toggle() throws {
        let app = XCUIApplication()
        app.launch()
        let navigationBar = app.navigationBars["Devices"]
        let searchButton = navigationBar.buttons["Search"]
        let searchField = app.searchFields["Search here..."]
        
        searchButton.tap()
        XCTAssertTrue(searchField.isHittable)
        searchButton.tap()
        XCTAssertFalse(searchField.isHittable)
    }
    
    func test_SideMenu_Toggle() throws {
        let app = XCUIApplication()
        app.launch()
        let navigationBar = app.navigationBars["Devices"]
        let menuButton = navigationBar.buttons["drag"]
        
        let sideBar = app.tables/*@START_MENU_TOKEN@*/.cells.containing(.image, identifier:"home").element/*[[".cells.containing(.staticText, identifier:\"Home\").element",".cells.containing(.image, identifier:\"home\").element"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
        XCTAssertFalse(sideBar.isHittable)
        menuButton.tap()
        XCTAssertTrue(sideBar.isHittable)
        menuButton.tap()
        XCTAssertFalse(sideBar.isHittable)
    }
 
    
}
