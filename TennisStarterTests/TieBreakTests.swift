//
//  TieBreakTests.swift
//  TennisStarter
//
//  Created by BEN  WILLIAMS on 28/03/2023.
//  Copyright © 2023 University of Chester. All rights reserved.
//

import XCTest
@testable import TennisStarter

class TieBreakTests: XCTestCase {
    var tieBreakT : TieBreak!
     var setT: Set!
     var match: Match!
     var game: Game!
     var mirror: Mirror!
     var matchLogic: GameProgressionLogic! //handles the logic
     
     override func setUp() {
         super.setUp()
         game = Game()
         setT = Set()
         match = Match();
         tieBreakT = TieBreak();
         matchLogic = GameProgressionLogic()
         mirror = Mirror(reflecting: game!)
         mirror = Mirror(reflecting: setT!)
         mirror = Mirror(reflecting: match!)

     }
     
     override func tearDown() {
         super.tearDown()
     }
    func testTieBreakGameSet5(){
        GetToSet5TieBreak()
        XCTAssertTrue(tieBreak.Check())
    }
    func testNoTieBreakSet5(){
        for count in (1...12) {
            if (count <= 2){
                match.addSetToPlayer1();
                match.addSetToPlayer2();
            }
            if (count <= 11) {
                setT.addGameToPlayer2();
            }
        }
        XCTAssertFalse(tieBreak.Check())
    }
    func testTieBreak(){
        getToSixAllTieBreak();
        XCTAssertTrue(tieBreak.Check())
    }
    func testNoTieBreak(){
        for _ in (1...5) {
            setT.addGameToPlayer2();
            setT.addGameToPlayer1();
        }
        XCTAssertFalse(tieBreak.Check())
    }
    func testMatchWinPlayer1(){
        //tie break 12-12, sets 2-2
        GetToSet5TieBreak()
        for _ in 1...7 {
            game.addPointToPlayer1();
        }
        /*print("Player 1 sets player \(match.player1Sets())");
        print("Player 2 sets player \(match.player2Sets())");
        print("Player 1 games player \(setT.player1Games())");
        print("Player 2 games player \(setT.player2Games())");
        print("Player 1 points player \(Player1.GetPointsWon())");
        print("Player 2 points player \(Player2.GetPointsWon())");*/
        
        XCTAssertTrue(game.player1Won())
        XCTAssertEqual("7" ,game.player1Score() , "Test points for player 1 in tiebreak")
        matchLogic.player1() //update game logic
        XCTAssertTrue(match.player1Won())
    }
     func testMatchWinPlayer2(){
         GetToSet5TieBreak()
         for _ in 1...7 {
             game.addPointToPlayer2();
         }
         XCTAssertTrue(game.player2Won())
         XCTAssertEqual("7" ,game.player2Score() , "Test points for player 1 in tiebreak")
         matchLogic.player2() //update game logic
         XCTAssertTrue(match.player2Won())
         XCTAssertTrue(match.player2Won() &&  match.matchEnded())
     }
    func testTieBreakSetWinPlayer1(){
        print("\n\n 9. testSetWinPlayer2Margin \n")
        // 7-6 tiebreak win Player 1
        print("\n\ntestTieBreakSetWinPlayer1")
        getToSixAllTieBreak();
        setT.addGameToPlayer1();
        XCTAssertTrue(setT.player1WonSet())
    }
    func testTieBreakSetWinPlayer2(){
        print("\n\n10.testTieBreakSetWinPlayer2")
        // 7-6 tiebreak win Player 2
        getToSixAllTieBreak();
        setT.addGameToPlayer2()
        XCTAssertTrue(setT.player2WonSet())
    }
    func testTieBreakMargin() {
        GetToSet5TieBreak()
        for count in 1...7 {
            game.addPointToPlayer1();
            if (count <= 6){
                game.addPointToPlayer2()
            }
        }
        XCTAssertFalse(game.player1Won())
        game.addPointToPlayer1()
        XCTAssertTrue(game.player1Won())
    }
    func GetToSet5TieBreak(){
        for count in (1...12) {
            if (count <= 2){
                match.addSetToPlayer1();
                match.addSetToPlayer2();
            }
            setT.addGameToPlayer2();
            setT.addGameToPlayer1();
        }
    }
    func getToSixAllTieBreak(){
        for _ in (1...6) {
            setT.addGameToPlayer1();
            setT.addGameToPlayer2();
        }
    }
}

