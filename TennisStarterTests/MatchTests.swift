//
//  matchTests.swift
//  TennisStarter
//
//  Created by BEN  WILLIAMS on 04/03/2023.
//  Copyright © 2023 University of Chester. All rights reserved.
//


import Foundation
import XCTest
 
class MatchTests: XCTestCase {
    var match: Match!
    var mirror: Mirror!
    
    override func setUp() {
        super.setUp()
        match = Match();
        mirror = Mirror(reflecting: match!)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    func testPlayerOneWin(){
        for _ in (0...2){
            match.addSetToPlayer1();
        }
        XCTAssertTrue(match.player1Won() &&  match.matchEnded())
    }
    func testPlayerTwoWin(){
        for _ in (0...2){
            match.addSetToPlayer2();
        }
        XCTAssertTrue(match.player2Won() &&  match.matchEnded())
    }
}
