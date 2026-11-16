//
//  MatchManagerTests.swift
//  Umpire Tracker
//
//  Created by Vijith V G on 16/11/26.
//


import XCTest
@testable import Umpire_Tracker_Watch_App

final class MatchManagerTests: XCTestCase {
    var match: MatchManager!
    
    override func setUp() {
        super.setUp()
        // Initializes a fresh MatchManager before every test
        match = MatchManager()
    }
    
    override func tearDown() {
        match = nil
        super.tearDown()
    }
    
    func testInitialState() {
        XCTAssertEqual(match.totalRuns, 0)
        XCTAssertEqual(match.wickets, 0)
        XCTAssertEqual(match.totalLegalBalls, 0)
        XCTAssertEqual(match.displayOvers, "0.0")
        XCTAssertFalse(match.isOverComplete)
    }
    
    func testLegalDeliveries() {
        match.addDelivery(.four)
        match.addDelivery(.single)
        
        XCTAssertEqual(match.totalRuns, 5)
        XCTAssertNotEqual(match.totalRuns, 4)
        XCTAssertEqual(match.totalLegalBalls, 2)
        XCTAssertEqual(match.displayOvers, "0.2")
    }
    
    func testExtrasDoNotIncrementLegalBalls() {
        match.addExtra(type: .wide, runs: 2) // 1 wide + 1 extra run
        match.addExtra(type: .noBall, runs: 5) // No ball + boundary
        
        XCTAssertEqual(match.totalRuns, 7)
        XCTAssertEqual(match.totalLegalBalls, 0, "Wides and No-Balls should not count as legal deliveries")
    }
    
    func testByesIncrementLegalBalls() {
        match.addExtra(type: .bye, runs: 4)
        
        XCTAssertEqual(match.totalRuns, 4)
        XCTAssertEqual(match.totalLegalBalls, 1, "Byes should count as a legal delivery")
    }
    
    func testWicketOnLegalDelivery() {
        match.addWicket()
        
        XCTAssertEqual(match.wickets, 1)
        XCTAssertEqual(match.totalLegalBalls, 1)
    }
    
    func testWicketOnWide() {
        match.addWicket(extraType: .wide, runs: 1) // e.g., Stumped on a wide
        
        XCTAssertEqual(match.wickets, 1)
        XCTAssertEqual(match.totalRuns, 1)
        XCTAssertEqual(match.totalLegalBalls, 0, "A wicket on a wide should not count as a legal delivery")
    }
    
    func testOverCompletionTrigger() {
        for _ in 1...5 {
            match.addDelivery(.dot)
        }
        XCTAssertFalse(match.isOverComplete)
        
        match.addDelivery(.dot) // 6th ball
        XCTAssertTrue(match.isOverComplete, "isOverComplete should be true after 6 legal deliveries")
        XCTAssertEqual(match.displayOvers, "1.0")
    }
    
    func testUndoLastAction() {
        match.addDelivery(.six)
        match.addExtra(type: .wide, runs: 1)
        match.addWicket()
        
        // State before undo: 7 runs, 1 wicket, 2 legal balls (six + wicket)
        XCTAssertEqual(match.totalRuns, 7)
        XCTAssertEqual(match.wickets, 1)
        XCTAssertEqual(match.totalLegalBalls, 2)
        
        // Undo Wicket
        match.undoLastAction()
        XCTAssertEqual(match.wickets, 0)
        XCTAssertEqual(match.totalLegalBalls, 1) // Ball from the wicket is removed
        
        // Undo Wide
        match.undoLastAction()
        XCTAssertEqual(match.totalRuns, 6)
        XCTAssertEqual(match.totalLegalBalls, 1) // Ball count remains 1 because wides don't increment it
        
        // Undo Six
        match.undoLastAction()
        XCTAssertEqual(match.totalRuns, 0)
        XCTAssertEqual(match.totalLegalBalls, 0)
    }
}
