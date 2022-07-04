@testable import MVP_Demo_iOS
import XCTest

final class MainViewControllerTests: XCTestCase {
    
    var sut : MainViewController!
    
    override func setUp() {
        super.setUp()
        let sb = UIStoryboard(name: "Main", bundle: nil)
        sut = sb.instantiateViewController(identifier: "\(MainViewController.self)")
        /// Create spy for main presenter
        let presenterSpy = MainPresenterSpy()
        /// Assign spy to presenter
        sut.presenter = presenterSpy
        /// Assign delegate of presenter to sut, due it was implemented there
        presenterSpy.delegate = sut
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        executeRunLoop()
        super.tearDown()
    }
    
    func test_outlet_shouldBeConnected() {
        XCTAssertNotNil(sut.tableView, "tableView")
        XCTAssertNotNil(sut.refreshButton, "refreshButton")
    }
    
    func test_action_shouldCanBeTapped() {
        tap(sut.refreshButton)
    }
    
    func test_delegates_shouldBeAssigned() {
        XCTAssertNotNil(sut.tableView.dataSource, "dataSource")
        XCTAssertNotNil(sut.presenter.delegate, "presenter delegate")
    }
    
    func test_refreshButton_withTap_shouldDisplaySpinnerHave0LeagueData() {
        tap(sut.refreshButton)
        
        XCTAssertEqual(sut.leagueData.count, 0)
    }
    
    func test_tableview_numberOfRowsInSection_withNoData_shouldDisplay0RowCell() {
        sut.leagueData = []
        
        let numberOfCell = numberOfRowsInSection(sut.tableView)
        
        XCTAssertEqual(numberOfCell, 0)
    }
    
    func test_tableView_numberOfRowsInSection_with3Data_shouldDisplay3RowCell() {
        sut.leagueData = [
            createLeagueData("A-League"),
            createLeagueData("J-League"),
            createLeagueData("K-League")
        ]
        
        let numberOfCell = numberOfRowsInSection(sut.tableView)
        
        XCTAssertEqual(numberOfCell, 3)
    }
    
    
    func test_tableView_cellForRowAt_withOneData_AtRow0shouldDisplayLabel_ALegue() {
        sut.leagueData = [
            createLeagueData("A-League")
        ]
        
        let cell =  cellForRowAt(sut.tableView, row: 0)
        
        XCTAssertEqual(cell?.textLabel?.text, "A-League")
    }
    
    
    func test_tableView_cellForRowAt_withThreeData_AtRow2_shouldDisplayLabel_PremierLeague(){
        sut.leagueData = [
            createLeagueData("A-League"),
            createLeagueData("J-League"),
            createLeagueData("Premier League")
        ]
        
        let cell = cellForRowAt(sut.tableView, row: 2)
        
        XCTAssertEqual(cell?.textLabel?.text, "Premier League")
    }
    
    func test_presenter_presenterActionWhenRefreshed_withNoInitialData_shouldDisplaySpinnerAnd0LeagueData() {
        
        presentActionWhenRefresh(sut.presenter)
        
        XCTAssertNotNil(spinnerView, "spinnerView")
        XCTAssertEqual(sut.leagueData.count, 0)
    }
    
    func test_presenterActionWhenRefresh_withInitialData_shouldDisplaySpinnerAnd0LeagueDat() {
        sut.leagueData = [
            createLeagueData("A-League"),
            createLeagueData("Bundesliga")
        ]
        
        presentActionWhenRefresh(sut.presenter)
        
        XCTAssertNotNil(spinnerView, "spinnerView")
        XCTAssertEqual(sut.leagueData.count, 0)
    }
    
    func test_presentListLeague_withNoLeagueDataAssigned_shouldRemoveSpinnerAndHave0LeagueData() {
        /// Create expectation for spinner to being remove
        let expectation = expectation(description: "spinnerView removed")
        /// Add timer to wait spinner being remove
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }
        
        presentListOfLeague(sut.presenter, data: [])
        
        /// Wait for expectation to be fullfill before assert
        wait(for: [expectation], timeout: 1)
        
        XCTAssertNil(spinnerView, "spinnerView")
        XCTAssertEqual(self.sut.leagueData.count, 0)
    }
    
    func test_presentListLeague_with3LeaguDataAssigned_shouldRemoveSpinnerAndHave2LeagueData() {
        
        let expectation = expectation(description: "spinnerView removed")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }
        
        presentListOfLeague(sut.presenter, data: [
            createLeagueData("A League"),
            createLeagueData("B League")
        ])
        
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertNil(spinnerView, "spinnerView")
        XCTAssertEqual(sut.leagueData.count, 2)
    }
}






