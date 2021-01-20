//
//  ApplicationUITests.swift
//  ApplicationUITests
//
//  Created by Victor C Tavernari on 20/01/21.
//

import XCTest

class ApplicationUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testShowDetails() throws {
        let app = XCUIApplication()
        app.launch()
        _ = app.waitForExistence(timeout: 2)
        app.cells.firstMatch.tap()
        _ = app.waitForExistence(timeout: 1)
        XCTAssert(app.staticTexts["Location"].exists)
        XCTAssert(app.staticTexts["Origin"].exists)
        XCTAssert(app.staticTexts["Nowadays"].exists)
        XCTAssert(app.staticTexts["Infos"].exists)
        XCTAssert(app.staticTexts["Gender"].exists)
        XCTAssert(app.staticTexts["Species"].exists)
        XCTAssert(app.staticTexts["Is it alive?"].exists)

    }

//    func testFavorite() {
//        if let bundleID = Bundle.main.bundleIdentifier {
//            UserDefaults.standard.removePersistentDomain(forName: bundleID)
//        }
//
//        let app = XCUIApplication()
//        app.launch()
//        _ = app.waitForExistence(timeout: 2)
//        app.cells.firstMatch.buttons["heartButton"].tap()
//        _ = app.waitForExistence(timeout: 1)
//        XCTAssert(app.cells.firstMatch.)
//    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
