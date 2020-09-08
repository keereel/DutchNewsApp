//
//  DutchNewsAppUITests.swift
//  DutchNewsAppUITests
//
//  Created by Kirill Sedykh on 02.09.2020.
//  Copyright © 2020 Kirill Sedykh. All rights reserved.
//

import XCTest

class DutchNewsAppUITests: XCTestCase {

    let server = LocalServer()
    
    
    override func setUp() {
        server.start(port: 8383)
        server.stub(path: "/v2/top-headlines?country=nl&apiKey=fc69f71be70c4af78f93ecf90cbfbb1e&p=1", with: "HeadlinesResponse")
        
        continueAfterFailure = false
    }

    override func tearDown() {
        server.stop()
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        //XCTAssertTrue(app.tables.cells.containing(.staticText, identifier: "Dpgmedia.nl").element.waitForExistence(timeout: 5))

        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    /*
    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
    */
}
