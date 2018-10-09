import XCTest
@testable import FallingWords

class FallingWordsTests: XCTestCase {

    var viewModel: ViewModel!
    
    override func setUp() {
        viewModel = ViewModel(languageFrom: .EN, languageTo: .ES)
    }

    override func tearDown() {
        
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
