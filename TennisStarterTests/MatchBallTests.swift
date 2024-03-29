//
//  MatchBallsTests.swift
//  TennisStarter
//
//  Created by BEN  WILLIAMS on 28/03/2023.
//  Copyright © 2023 University of Chester. All rights reserved.
//

import XCTest

class MatchBallsTests: XCTestCase {

    var setT: Set!
    var mirror: Mirror!
    var matchBalls : MatchBalls!
    
    override func setUp() {
        super.setUp()
        setT = Set()
        matchBalls = MatchBalls()
        mirror = Mirror(reflecting: setT!)
        mirror = Mirror(reflecting: matchBalls!)
    }
    //Listen for sound when test is ran
    
    func testStartOfGameNewBallsCheck(){
        XCTAssertFalse(matchBalls.newBallsCheck())
    }
    func testAfter7Games(){
        //tests match balls after the first 7
        getTo7Games(); //get to 7 games
        //print("Player 2 games: \(Player2.GetCurrentGamesWonInSet())")
        //print("Player 1 games: \(Player1.GetCurrentGamesWonInSet())")
        XCTAssertTrue(matchBalls.newBallsCheck())
    }
    
    func testEvery9Games(){
        //Tests new match balls after every 9, after the first 7
        testAfter7Games()

        //--------------------------------------
        getTo9Games()
        XCTAssertTrue(matchBalls.newBallsCheck())
        //--------------------------------------
        setT.addGameToPlayer2() //make sure new balls
        setT.addGameToPlayer2()
        XCTAssertFalse(matchBalls.newBallsCheck())
        
        
        for _ in 0...7 {
            setT.addGameToPlayer1()
        }
        XCTAssertTrue(matchBalls.newBallsCheck())
    }

    func testMatchBallsOnReset(){
        //tests that the match balls can handle a game reset
        testEvery9Games()
        Player2.ResetPlayerScores() //reset scores
        Player1.ResetPlayerScores()
        matchBalls.resetBallsFetched()//resets the balls -> usually handled by reset pressed on UI
        XCTAssertFalse(matchBalls.newBallsCheck()) //falls after resets
        //tests recovery after reset 
        getTo7Games()
        XCTAssertTrue(matchBalls.newBallsCheck())
        getTo9Games()
        XCTAssertTrue(matchBalls.newBallsCheck())
    }
    func testAterConesecutive7Games(){
        testAfter7Games()
        getTo7Games()
        XCTAssertFalse(matchBalls.newBallsCheck())
        
    }
    private func getTo7Games(){
        for _ in 1...3 {
            setT.addGameToPlayer2()
            setT.addGameToPlayer1()
        }
        setT.addGameToPlayer2()
    }
    
    private func getTo9Games(){
        for _ in 1...4 { //8 games
            //print("Loop count \(count)")
            setT.addGameToPlayer1()
            setT.addGameToPlayer2()
        }
        setT.addGameToPlayer1()
        //print("Player 1 games: \(Player1.GetGamesWon())");
        //print("Player 2 games: \(Player2.GetGamesWon())");
    }
    
    
}

