//
//  ServingTests.swift
//  TennisStarter
//
//  Created by BEN  WILLIAMS on 28/03/2023.
//  Copyright © 2023 University of Chester. All rights reserved.
//
import XCTest
@testable import TennisStarter
class ServingTests: XCTestCase {
 
    var game: Game!
    var mirror: Mirror!
    var serve : Serve!
    var set : Set!
    var controller: ViewController!
    var tieBreak : TieBreak!
    override func setUp() {
        super.setUp()
        game = Game()
        set = Set()
        serve = Serve()
        tieBreak = TieBreak()
        controller = ViewController()
        mirror = Mirror(reflecting: game!)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    func testPlayerOneServingAtBeginning(){
        //assert playerOne is serving at the beginning
        XCTAssertTrue(serve.NextServe(newMatch: false)) //returns true if player one is serving else false
    }
    func testplayer1ServingOnRestart(){
        testServeChangeToPlayer2()
        //controller.restartPressed()
        XCTAssertTrue(serve.NextServe(newMatch: true))
    }
    func testServeChangeToPlayer2(){
        for _ in 1...4{
            game.addPointToPlayer1()
        }
        print("Player 1: \(Player1.GetPointsWon())")
        
        XCTAssertFalse(serve.NextServe(newMatch: false))
    }
    func testTieBreakServeChange(){
        let currentServer = serve.NextServe(newMatch: false);
        for _ in (1...6) {
            set.addGameToPlayer1();
            set.addGameToPlayer2();
        }

        XCTAssertEqual(serve.NextServe(newMatch: false), !currentServer, "Test serve change on initial tie break - similar to when a point has been added")
        XCTAssertEqual(serve.NextServe(newMatch: false), !currentServer, "No change in serve")
        XCTAssertEqual(serve.NextServe(newMatch: false), currentServer, "Change in serve - alternates every 2 points/calls")
    }
}

