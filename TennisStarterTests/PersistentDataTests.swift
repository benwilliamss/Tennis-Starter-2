//
//  PersistentDataTests.swift
//  TennisStarterTests
//
//  Created by BEN  WILLIAMS on 05/04/2023.
//  Copyright © 2023 University of Chester. All rights reserved.
//
import XCTest
import Foundation
class PersistentDataTests: XCTestCase {
    
    var game   : Game!
    var set    : Set!
    var match  :  Match!
    var mirror: Mirror!
    
    override func setUp() {
        super.setUp()
        game = Game()
        set = Set()
        match = Match()
        mirror = Mirror(reflecting: game!)
        mirror = Mirror(reflecting: set!)
        mirror = Mirror(reflecting: match!)
    }
    
    func testDataOnStartUp(){
        print("Stored data: \(PlayerPersistentData().Read())")
        XCTAssertEqual(PlayerPersistentData().Read(), "Player1 Data Last Match \nsets: 0 games: 0 points: 0\nPlayer2 Data Last Match \nsets: 0 games: 0 points: 0", "No Storage data on project startup")
    }
    func testReadWriteData(){
        for _ in 1...3{
            game.addPointToPlayer2()
            game.addPointToPlayer1()
            set.addGameToPlayer1()
            set.addGameToPlayer2()
            match.addSetToPlayer1()
        }
        PlayerPersistentData().Write()
        print("Data read : \(PlayerPersistentData().Read())")
        XCTAssertEqual(PlayerPersistentData().Read(),"Player1 Data Last Match \nsets: 3 games: 3 points: 40\nPlayer2 Data Last Match \nsets: 0 games: 3 points: 40", "Read the data from storage")
    }
    func testPowerDownRead(){
        //testReadWriteData()
        match.addSetToPlayer1() //add some processes to write
        match.addSetToPlayer2()
        set.addGameToPlayer1()
        set.addGameToPlayer2()
        PlayerPersistentData().Write()
        XCTAssertEqual(PlayerPersistentData().Read(),"Player1 Data Last Match \nsets: 1 games: 1 points: 0\nPlayer2 Data Last Match \nsets: 1 games: 1 points: 0", "Read the data from storage")
        
        //User task: power down/restart the app
        //check output is:
        /*
         Player1 Data Last Match
         sets: 1 games: 1 points: 0
         Player2 Data Last Match
         sets: 1 games: 1 points: 0
         */
        
        
    }
}
