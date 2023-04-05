//
//  PlayerTests.swift
//  TennisStarterTests
//
//  Created by BEN  WILLIAMS on 05/04/2023.
//  Copyright © 2023 University of Chester. All rights reserved.
//

import Foundation
import XCTest
class PlayerTests: XCTestCase {
    var newPlayer1 :Player!
    var newPlayer2 : Player!
    var mirror: Mirror!

    override func setUp() {
        super.setUp()
        newPlayer1 = Player()
        newPlayer2 = Player()
        mirror = Mirror(reflecting: newPlayer1!)
        mirror = Mirror(reflecting: newPlayer2!)
    }
    //Tests player values on start of
    
    func testStartObjectValue(){
        //player 1 values
        XCTAssertEqual(newPlayer1.GetCurrentGamesWonInSet(), 0, "test empty on start")
        XCTAssertEqual(newPlayer1.GetGamesWonInMatch(), 0, "test empty on start")
        XCTAssertEqual(newPlayer1.GetPointsWon(), "0", "test empty on start")
        XCTAssertEqual(newPlayer1.GetSetsWon(), 0, "test empty on start")
        //player 2 values
        XCTAssertEqual(newPlayer2.GetCurrentGamesWonInSet(), 0, "test empty on start")
        XCTAssertEqual(newPlayer2.GetGamesWonInMatch(), 0, "test empty on start")
        XCTAssertEqual(newPlayer2.GetPointsWon(), "0", "test empty on start")
        XCTAssertEqual(newPlayer2.GetSetsWon(), 0, "test empty on start")
    }
    //test player reset value
    func testResetValue(){
        testUpdatePointsValue()
        testUpdateGamesValue()
        testUpdateSetsValue()
        newPlayer1.ResetValue() //reset values back to 0
        newPlayer2.ResetValue() //reset values back to 0 
        testStartObjectValue()
    }
    //test player updates
    func testUpdatePointsValue(){
        newPlayer1.UpdatePointsWon(newValue: "30")
        newPlayer2.UpdatePointsWon(newValue: "15")
        XCTAssertEqual(newPlayer1.GetPointsWon(), "30", "test matches updated values")
        XCTAssertEqual(newPlayer2.GetPointsWon(), "15", "test matches updated values")
        newPlayer1.UpdatePointsWon(newValue: "40")
        newPlayer2.UpdatePointsWon(newValue: "A")
        XCTAssertEqual(newPlayer1.GetPointsWon(), "40", "test matches updated values")
        XCTAssertEqual(newPlayer2.GetPointsWon(), "A", "test matches updated values")
    }
    func testUpdateSetsValue(){
        //include illegal value
        newPlayer1.UpdateSetsWon(newValue: 3)
        newPlayer2.UpdateSetsWon(newValue: 2)
        XCTAssertEqual(newPlayer1.GetSetsWon(), 3, "test matches updated values")
        XCTAssertEqual(newPlayer2.GetSetsWon(), 2, "test matches updated values")
        
        newPlayer1.UpdateSetsWon(newValue: -1)
        newPlayer2.UpdateSetsWon(newValue: -2)
        XCTAssertEqual(newPlayer1.GetSetsWon(), 0, "test illegal values")
        XCTAssertEqual(newPlayer2.GetSetsWon(), 0, "test illegal values")
        newPlayer1.UpdateSetsWon(newValue: 1)
        newPlayer2.UpdateSetsWon(newValue: 3)
        XCTAssertEqual(newPlayer1.GetSetsWon(), 1, "test matches updated values")
        XCTAssertEqual(newPlayer2.GetSetsWon(), 3, "test matches updated values")
    }
    
    func testUpdateGamesValue(){
       //include illegal value
        newPlayer1.UpdateGamesWon(newValue: 6)
        newPlayer2.UpdateGamesWon(newValue: 7)
        XCTAssertEqual(newPlayer1.GetCurrentGamesWonInSet(), 6, "test matches updated values")
        XCTAssertEqual(newPlayer2.GetCurrentGamesWonInSet(), 7, "test matches updated values")
        
        newPlayer1.UpdateGamesWon(newValue: -1)
        newPlayer2.UpdateGamesWon(newValue: -2)
        XCTAssertEqual(newPlayer1.GetCurrentGamesWonInSet(), 0, "test illegal values")
        XCTAssertEqual(newPlayer2.GetCurrentGamesWonInSet(), 0, "test illegal values")
        
        newPlayer1.UpdateGamesWon(newValue: 4)
        newPlayer2.UpdateGamesWon(newValue: 5)
        XCTAssertEqual(newPlayer1.GetCurrentGamesWonInSet(), 4, "test matches updated values")
        XCTAssertEqual(newPlayer2.GetCurrentGamesWonInSet(), 5, "test matches updated values")
    }
    
    func testGamesWonInMatch(){
        newPlayer1.UpdateGamesWon(newValue: 6)
        print(set.complete())
        newPlayer2.UpdateGamesWon(newValue: 6)
        print(set.complete())
        XCTAssertEqual(newPlayer1.GetGamesWonInMatch(), 6, "test matches updated values")
        XCTAssertEqual(newPlayer2.GetGamesWonInMatch(), 6, "test matches updated values")
        print("Games count player 1: \(set.player1Games()) && player count : \(Player1.GetCurrentGamesWonInSet())")
        print("Games count player 2: \(set.player1Games()) && player count : \(Player2.GetCurrentGamesWonInSet())")
        newPlayer1.UpdateGamesWon(newValue: 2)
        newPlayer2.UpdateGamesWon(newValue: 3)
        
        XCTAssertEqual(newPlayer1.GetGamesWonInMatch(), 8, "test matches updated values")
        XCTAssertEqual(newPlayer2.GetGamesWonInMatch(), 9, "test matches updated values")
    }
}
