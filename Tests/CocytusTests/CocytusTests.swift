import XCTest
@testable import Cocytus

final class CocytusTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Cocytus().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
