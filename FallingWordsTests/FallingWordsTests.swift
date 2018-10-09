import XCTest
@testable import FallingWords

class FallingWordsTests: XCTestCase {

    var viewModel: ViewModel!
    
    override func setUp() {
        viewModel = ViewModel(languageFrom: .EN, languageTo: .ES)
    }

    override func tearDown() {
        
    }

    func testInitViewModelReadsCorrectlyFromJson() {
        viewModel.setPairOfTranslations(number: 5)
        XCTAssertFalse(viewModel.translationToPlay == nil)
        XCTAssertFalse(viewModel.movingTranlation == nil)
    }
    
    func testAddNonOkOfPointIsIncreased() {
        XCTAssertEqual(viewModel.nonOkPoints, 0)
        viewModel.addNonOkPoint()
        XCTAssertEqual(viewModel.nonOkPoints, 1)
    }
    
    func testIsCorrectTranslation() {
        viewModel.setPairOfTranslations(number: 5)
        XCTAssertFalse(viewModel.isCorrectTranslation)
    }

    func testAddOkOfPointIsIncreased() {
        XCTAssertEqual(viewModel.okPoints, 0)
        viewModel.addOkPoint()
        XCTAssertEqual(viewModel.okPoints, 1)
    }
    
    func testUserHasWinIsCorrect() {
        XCTAssertEqual(viewModel.okPoints, 0)
        for _ in 1...10 {
            XCTAssertFalse(viewModel.userHasWin())
            viewModel.addOkPoint()
        }
        XCTAssertEqual(viewModel.okPoints, 10)
        XCTAssertTrue(viewModel.userHasWin())
    }
    
    func testUserHasLostIsCorrect() {
        XCTAssertEqual(viewModel.nonOkPoints, 0)
        for _ in 1...3 {
            XCTAssertFalse(viewModel.userHasLost())
            viewModel.addNonOkPoint()
        }
        XCTAssertEqual(viewModel.nonOkPoints, 3)
        XCTAssertTrue(viewModel.userHasLost())
    }
    
    func testRestartSetAllScoresInitial() {
        XCTAssertEqual(viewModel.nonOkPoints, 0)
        XCTAssertEqual(viewModel.okPoints, 0)
        for _ in 1...2 {
            viewModel.addNonOkPoint()
            viewModel.addOkPoint()
        }
        XCTAssertEqual(viewModel.nonOkPoints, 2)
        XCTAssertEqual(viewModel.okPoints, 2)
        
        viewModel.restart()
        
        XCTAssertEqual(viewModel.nonOkPoints, 0)
        XCTAssertEqual(viewModel.okPoints, 0)
    }

}
