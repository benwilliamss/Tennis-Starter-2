//
//  SetTests.swift
//  TennisStarter
//
//  Created by BEN  WILLIAMS on 04/03/2023.
//  Copyright © 2023 University of Chester. All rights reserved.
//

import Foundation
import XCTest
// game test
class SetTests: XCTestCase {
    
    var setT: Set!
    var game: Game!
    var mirror: Mirror!
    
    override func setUp() {
        super.setUp()
        game = Game()
        mirror = Mirror(reflecting: game!)
        setT = Set()
        mirror = Mirror(reflecting: setT!)
        
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testSetWinPlayer1NoMargin(){
        print("\n\n1. testSetWinPlayer1NoMargin\n")
        //Test no win when there is no margin achieved but game count is reached - player 1
        for _ in (1...5) {
            setT.addGameToPlayer1();
            setT.addGameToPlayer2();
        }
        setT.addGameToPlayer1();
        XCTAssertFalse(setT.player1WonSet())
    }
    
    func testSetNoWinPlayer2NoMargin(){
        print("\n\n 3. testSetNoWinPlayer1NoMargin \n")
        for _ in (1...5) {
            setT.addGameToPlayer1();
            setT.addGameToPlayer2();
        }
        setT.addGameToPlayer2();
        XCTAssertFalse(setT.player2WonSet())
    }
    
    func testSetWinPlayer1Margin(){
        //Test no win when there is no margin achieved but game count is reached - player 2
        print("\n\n 2. testSetWinPlayer1Margin \n")
        for _ in (1...4) {
            setT.addGameToPlayer1();
            setT.addGameToPlayer2();
        }
        setT.addGameToPlayer1();
        setT.addGameToPlayer1();
        XCTAssertTrue(setT.player1WonSet())
    }
    func testSetWinPlayer2Margin(){
        print("\n\n 4. testSetWinPlayer2Margin \n")
        for _ in (1...4) {
            setT.addGameToPlayer1();
            setT.addGameToPlayer2();
        }
        setT.addGameToPlayer2();
        setT.addGameToPlayer2();
        XCTAssertTrue(setT.player2WonSet())
    }

    func testAddGamesPlayer1(){
        print("\n\n 5. testAddGamesPlayer1\n")
        for count in (1...5) {
            setT.addGameToPlayer1();
            XCTAssertEqual(setT.player1Games(), count, accuracy: 0);
        }
    }
    func testAddGamesPlayer2(){
        print("\n\n 6. testAddGamesPlayer2 \n")
        for count in (1...6) {
            setT.addGameToPlayer2();
            XCTAssertEqual(setT.player2Games(), count, accuracy: 0);
        }
    }
    func testZeroPointsPlayer1(){
        print("\n\n 7. ntestZeroPointsPlayer1\n")
        XCTAssertEqual(setT.player1Games(), 0, accuracy: 0);
    }
    func testZeroPointsPlayer2(){
        print("\n\n 8. ntestZeroPointsPlayer2\n")
    }
    
}

