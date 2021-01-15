import XCTest
@testable import CharacterList

final class CharacterListTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(CharacterList().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
