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
        for _ in 0...2{
            newPlayer1.UpdateSetsWon() //Increment
            newPlayer2.UpdateSetsWon() //increment to 1
        }
        XCTAssertEqual(newPlayer1.GetSetsWon(), 3, "test matches updated values")
        XCTAssertEqual(newPlayer2.GetSetsWon(), 3, "test matches updated values")
        newPlayer1.UpdateSetsWon()
        newPlayer1.UpdateSetsWon()
        newPlayer2.UpdateSetsWon()
        XCTAssertEqual(newPlayer1.GetSetsWon(), 5, "test matches updated values")
        XCTAssertEqual(newPlayer2.GetSetsWon(), 4, "test matches updated values")
        newPlayer1.UpdateSetsWon()
        newPlayer2.UpdateSetsWon()
        XCTAssertEqual(newPlayer1.GetSetsWon(), 6, "test matches updated values")
        XCTAssertEqual(newPlayer2.GetSetsWon(), 5, "test matches updated values")
    }
    
    func testUpdateGamesValue(){
       //include illegal value
        newPlayer1.UpdateGamesWon()
        newPlayer2.UpdateGamesWon()
        XCTAssertEqual(newPlayer1.GetCurrentGamesWonInSet(), 1, "test matches updated values")
        XCTAssertEqual(newPlayer2.GetCurrentGamesWonInSet(), 1, "test matches updated values")
        
        newPlayer1.UpdateGamesWon()
        newPlayer2.UpdateGamesWon()
        XCTAssertEqual(newPlayer1.GetCurrentGamesWonInSet(), 2, "test illegal values")
        XCTAssertEqual(newPlayer2.GetCurrentGamesWonInSet(), 2, "test illegal values")
        
        newPlayer1.UpdateGamesWon()
        newPlayer2.UpdateGamesWon()
        newPlayer2.UpdateGamesWon()
        XCTAssertEqual(newPlayer1.GetCurrentGamesWonInSet(), 3, "test matches updated values")
        XCTAssertEqual(newPlayer2.GetCurrentGamesWonInSet(), 4, "test matches updated values")
    }
    
    func testGamesWonInMatch(){
        newPlayer1.UpdateGamesWon()
        newPlayer2.UpdateGamesWon()
        print("Games count player 1: \(newPlayer1.GetGamesWonInMatch()) && player count : \(newPlayer1.GetCurrentGamesWonInSet())")
        print("Games count player 2: \(newPlayer2.GetGamesWonInMatch()) && player count : \(newPlayer2.GetCurrentGamesWonInSet())")
        XCTAssertEqual(newPlayer1.GetGamesWonInMatch(), 1, "test matches updated values")
        XCTAssertEqual(newPlayer2.GetGamesWonInMatch(), 1, "test matches updated values")
        for _ in 1...6 {
            newPlayer1.UpdateGamesWon()
            newPlayer2.UpdateGamesWon()
        }
        print("Games count player 1: \(newPlayer1.GetGamesWonInMatch()) && player count : \(newPlayer1.GetCurrentGamesWonInSet())")
        print("Games count player 2: \(newPlayer2.GetGamesWonInMatch()) && player count : \(newPlayer2.GetCurrentGamesWonInSet())")
        XCTAssertEqual(newPlayer1.GetGamesWonInMatch(), 7, "test matches updated values")
        XCTAssertEqual(newPlayer2.GetGamesWonInMatch(), 7, "test matches updated values")
    }
}
