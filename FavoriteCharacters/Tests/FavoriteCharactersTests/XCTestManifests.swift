import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(FavoriteCharactersTests.allTests),
    ]
}
#endif
