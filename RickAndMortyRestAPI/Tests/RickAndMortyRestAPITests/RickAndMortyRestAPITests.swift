import XCTest
@testable import RickAndMortyRestAPI

final class RickAndMortyRestAPITests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(RickAndMortyRestAPI().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}